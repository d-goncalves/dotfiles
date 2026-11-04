#!/usr/bin/env bash
# Sets up this machine: tools (Homebrew), config links (stow) and plugins.
# Works on macOS, Linux and WSL. Safe to re-run.
set -euo pipefail

usage() {
    cat <<'EOF'
Usage: ./bootstrap.sh [options]

  --extras       also install Brewfile.extras (homelab tools and so on)
  --lsp          also install Brewfile.lsp (language servers for nvim)
  --no-brew      skip Homebrew; link configs only (for machines without admin rights)
  --no-plugins   skip oh-my-zsh, its plugins, and the nvim plugin and tool install
  --no-fonts     skip downloading the terminal font (Linux)
  --terminal     WSL only: install the font and apply the theme to Windows Terminal
                 (also done automatically when run inside Windows Terminal)
  --update       only update oh-my-zsh and the zsh plugins, then exit
  --dry-run      print what would happen, change nothing
  -h, --help     show this help
EOF
}

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NEW_CONFIG=0 EXTRAS=0 LSP=0 BREW=1 PLUGINS=1 FONTS=1 TERMINAL=0 UPDATE=0 DRY=0
for arg in "$@"; do
    case $arg in
        --extras) EXTRAS=1 ;;
        --lsp) LSP=1 ;;
        --no-brew) BREW=0 ;;
        --no-plugins) PLUGINS=0 ;;
        --no-fonts) FONTS=0 ;;
        --terminal) TERMINAL=1 ;;
        --update) UPDATE=1 ;;
        --dry-run) DRY=1 ;;
        -h | --help) usage; exit 0 ;;
        *) echo "Unknown option: $arg" >&2; usage >&2; exit 1 ;;
    esac
done

log() { printf '\n==> %s\n' "$*"; }
run() {
    if [ "$DRY" = 1 ]; then echo "+ $*"; else "$@"; fi
}

if [ "$UPDATE" = 1 ]; then
    log "Updating oh-my-zsh and its plugins"
    for dir in "${XDG_DATA_HOME:-$HOME/.local/share}/oh-my-zsh/" "${XDG_DATA_HOME:-$HOME/.local/share}/oh-my-zsh/custom/plugins"/*/; do
        [ -d "${dir}.git" ] || continue
        if run git -C "$dir" pull --ff-only -q; then echo "updated $(basename "$dir")"; else echo "could not update $(basename "$dir")" >&2; fi
    done
    exit 0
fi

case "$(uname -s)" in
    Darwin) OS=macos ;;
    Linux) OS=linux; grep -qi microsoft /proc/version 2>/dev/null && OS=wsl ;;
    *) echo "Unsupported system: $(uname -s)" >&2; exit 1 ;;
esac
log "Detected: $OS"

if [ "$(id -u)" = 0 ]; then
    echo "Run this as your normal user, not root." >&2
    exit 1
fi
if [ "$OS" != macos ] && [ "$BREW" = 1 ]; then
    missing=()
    for tool in curl git file; do command -v "$tool" >/dev/null 2>&1 || missing+=("$tool"); done
    command -v cc >/dev/null 2>&1 || missing+=(build-essential)
    if [ "${#missing[@]}" -gt 0 ] && [ "$DRY" = 0 ]; then
        echo "Homebrew and the nvim parsers need: ${missing[*]}" >&2
        echo "On Ubuntu/Debian:  sudo apt-get install -y build-essential procps curl file git unzip" >&2
        exit 1
    fi
fi

find_brew() {
    for b in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew "$HOME/.linuxbrew/bin/brew"; do
        if [ -x "$b" ]; then echo "$b"; return; fi
    done
    command -v brew || true
}

if [ "$BREW" = 1 ]; then
    BREW_BIN="$(find_brew)"
    if [ -z "$BREW_BIN" ]; then
        log "Installing Homebrew"
        run /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        BREW_BIN="$(find_brew)"
    fi
    if [ -n "$BREW_BIN" ]; then eval "$("$BREW_BIN" shellenv)"; fi
    log "Installing core tools"
    run brew bundle --file="$DOTFILES/Brewfile"
    if [ "$EXTRAS" = 1 ]; then
        log "Installing extras"
        run brew bundle --file="$DOTFILES/Brewfile.extras"
    fi
    if [ "$LSP" = 1 ]; then
        log "Installing language servers"
        run brew bundle --file="$DOTFILES/Brewfile.lsp"
    fi
    if command -v brew >/dev/null 2>&1 && brew --prefix rustup >/dev/null 2>&1; then
        export PATH="$(brew --prefix rustup)/bin:$PATH"
        if ! rustup toolchain list 2>/dev/null | grep -q '^stable-'; then
            log "Installing the stable Rust toolchain"
            run rustup toolchain install stable --profile minimal
        fi
        rustup show active-toolchain >/dev/null 2>&1 || run rustup default stable
    fi
else
    log "Skipping Homebrew. Install the tools listed in Brewfile yourself."
fi

log "Preparing ~/code/config (machine-specific files, kept out of this repo)"
CONFIG_DIR="$HOME/code/config"
run mkdir -p "$CONFIG_DIR"
# Older layouts used ~/work/config (and before that files directly in ~/work); move them over once
for f in zsh .gitconfig; do
    [ -e "$CONFIG_DIR/$f" ] && continue
    for old in "$HOME/work/config/$f" "$HOME/work/$f" "$HOME/work/.$f"; do
        if [ -f "$old" ]; then run mv "$old" "$CONFIG_DIR/$f"; break; fi
    done
done
# Anything still missing starts from the templates in config.example/
for f in zsh .gitconfig; do
    if [ ! -e "$CONFIG_DIR/$f" ]; then
        run cp "$DOTFILES/config.example/$f" "$CONFIG_DIR/$f"
        NEW_CONFIG=1
    fi
done

# This repo is public: refuse commits and pushes that contain credentials (hooks)
run git -C "$DOTFILES" config core.hooksPath hooks

log "Linking configs with stow"
if ! command -v stow >/dev/null 2>&1 && [ "$DRY" = 0 ]; then
    echo "stow not found. Install it (brew install stow, or apt install stow) and re-run." >&2
    exit 1
fi
# Links left behind by older bootstrap versions can be absolute, which Stow does not own.
# Remove links into this repo so Stow can recreate them with its managed relative links.
REL="${DOTFILES#"$HOME"/}"
for dir in "$HOME" "$HOME/.config" "$HOME/.config/git" "$HOME/.config/zsh" \
           "$HOME/.config/tmux" "$HOME/.config/nvim" "$HOME/.config/starship" "$HOME/.local/bin" \
           "$HOME/Library/Application Support/iTerm2/DynamicProfiles"; do
    [ -d "$dir" ] || continue
    for l in "$dir"/* "$dir"/.[!.]*; do
        if [ -L "$l" ]; then
            t="$(readlink "$l")"
            case "$t" in
                "$DOTFILES"/* | "$REL"/*)
                    echo "removing old repo link: $l"
                    run rm "$l"
                    ;;
            esac
        fi
    done
done

# Real directories, so stow links single files instead of whole folders (which would let tools write into this repo)
run mkdir -p "$HOME/.config" "$HOME/.local/bin" "$HOME/.local/state/zsh"
# ~/.config/zsh must be a real directory with single links in it. As a link to the repo folder,
# everything zsh writes there (history, sessions) would land inside this public repo.
run stow -d "$DOTFILES" -t "$HOME" -D zsh 2>/dev/null || true
run mkdir -p "$HOME/.config/zsh"

link() {   # link <directory holding the package> <package>
    if ! run stow -d "$1" -t "$HOME" -R "$2"; then
        echo "Could not link '$2': a real file is in the way (see the message above)." >&2
        echo "Move it aside, for example: mv ~/.config/$2 ~/.config/$2.bak, then re-run." >&2
        exit 1
    fi
}
for pkg in zsh git tmux nvim; do link "$DOTFILES" "$pkg"; done

# desktop/<os>: terminal and window-manager config for this system. desktop/windows is not linked
# (WSL applies it to Windows Terminal through desktop/windows/windows-terminal.sh instead).
case "$OS" in
    macos)
        run mkdir -p "$HOME/Library/Application Support/iTerm2/DynamicProfiles"
        link "$DOTFILES/desktop" macos ;;
    linux)
        if command -v sway >/dev/null 2>&1 || command -v alacritty >/dev/null 2>&1; then link "$DOTFILES/desktop" linux; fi ;;
esac

if [ "$OS" = macos ]; then
    # Make the iTerm profile from this repo the default one. Restart iTerm to see it.
    ITERM_PROFILE="$DOTFILES/desktop/macos/Library/Application Support/iTerm2/DynamicProfiles/vivid-black.json"
    ITERM_GUID="$(plutil -extract Profiles.0.Guid raw -o - "$ITERM_PROFILE")"
    log "Setting the iTerm default profile"
    run defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "$ITERM_GUID"
fi

if [ "$PLUGINS" = 1 ]; then
    log "Installing oh-my-zsh and the zsh plugins"
    clone() { if [ ! -d "$2/.git" ]; then run git clone --depth 1 "$1" "$2"; fi; }
    clone https://github.com/ohmyzsh/ohmyzsh.git "${XDG_DATA_HOME:-$HOME/.local/share}/oh-my-zsh"
    C="${XDG_DATA_HOME:-$HOME/.local/share}/oh-my-zsh/custom/plugins"
    run mkdir -p "$C"
    clone https://github.com/zsh-users/zsh-autosuggestions "$C/zsh-autosuggestions"
    clone https://github.com/zsh-users/zsh-syntax-highlighting "$C/zsh-syntax-highlighting"
    clone https://github.com/zsh-users/zsh-completions "$C/zsh-completions"
    clone https://github.com/Aloxaf/fzf-tab "$C/fzf-tab"

    if command -v nvim >/dev/null 2>&1; then
        log "Installing nvim plugins and tools (lazy.nvim, mason)"
        run nvim --headless "+Lazy! restore" "+MasonToolsInstallSync" +qa
    fi
fi

if [ "$OS" = wsl ] && { [ "$TERMINAL" = 1 ] || [ -n "${WT_SESSION:-}" ]; }; then
    log "Windows Terminal: font and theme"
    run bash "$DOTFILES/desktop/windows/windows-terminal.sh"
fi

if [ "$FONTS" = 1 ]; then
    case $OS in
        linux)
            FONT_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/fonts/JetBrainsMonoNerdFont"
            if [ ! -d "$FONT_DIR" ]; then
                log "Installing JetBrainsMono Nerd Font"
                run mkdir -p "$FONT_DIR"
                FONT_ZIP="$(mktemp)"
                run curl -fsSL -o "$FONT_ZIP" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
                run unzip -qo "$FONT_ZIP" -d "$FONT_DIR"
                run rm -f "$FONT_ZIP"
                run fc-cache -f "$FONT_DIR"
            fi
            ;;
        wsl)
            log "Font: Windows Terminal uses JetBrainsMono Nerd Font (see README)" ;;
    esac
fi

echo
echo "Done. Next steps:"
echo "  - Machine-specific config lives in ~/code/config/zsh (shell) and ~/code/config/.gitconfig (git identity, signing)"
if [ "$NEW_CONFIG" = 1 ]; then
    echo "  - Edit ~/code/config/.gitconfig now: it has a placeholder name and email (created from config.example/)"
fi
echo '  - Make zsh your default shell if it is not:  chsh -s "$(command -v zsh)"'

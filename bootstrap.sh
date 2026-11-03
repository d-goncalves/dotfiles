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
  --no-plugins   skip cloning zsh and tmux plugins
  --no-fonts     skip downloading the terminal font (Linux)
  --update       only update the installed zsh and tmux plugins, then exit
  --dry-run      print what would happen, change nothing
  -h, --help     show this help
EOF
}

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXTRAS=0 LSP=0 BREW=1 PLUGINS=1 FONTS=1 UPDATE=0 DRY=0
for arg in "$@"; do
    case $arg in
        --extras) EXTRAS=1 ;;
        --lsp) LSP=1 ;;
        --no-brew) BREW=0 ;;
        --no-plugins) PLUGINS=0 ;;
        --no-fonts) FONTS=0 ;;
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
    log "Updating plugins"
    for dir in "${XDG_DATA_HOME:-$HOME/.local/share}"/zsh/plugins/*/ "${XDG_DATA_HOME:-$HOME/.local/share}"/tmux/plugins/*/; do
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
else
    log "Skipping Homebrew. Install the tools listed in Brewfile yourself."
fi

log "Preparing ~/work/config (machine-specific files, kept out of this repo)"
WORK_CONFIG="$HOME/work/config"
run mkdir -p "$WORK_CONFIG"
# Older layout kept these files directly in ~/work; move them over once
for pair in .zsh:zsh .gitconfig:.gitconfig; do
    old="$HOME/work/${pair%%:*}" new="$WORK_CONFIG/${pair##*:}"
    if [ -f "$old" ] && [ ! -e "$new" ]; then
        run mv "$old" "$new"
    fi
done

log "Linking configs with stow"
if ! command -v stow >/dev/null 2>&1 && [ "$DRY" = 0 ]; then
    echo "stow not found. Install it (brew install stow, or apt install stow) and re-run." >&2
    exit 1
fi
PACKAGES=(zsh git tmux nvim alacritty starship)
if command -v sway >/dev/null 2>&1; then PACKAGES+=(linux-desktop); fi
if [ "$OS" = macos ]; then
    PACKAGES+=(iterm)
    run mkdir -p "$HOME/Library/Application Support/iTerm2/DynamicProfiles"
fi
run mkdir -p "$HOME/.config" "$HOME/.local/state/zsh"   # stops stow from linking the whole ~/.config
for pkg in "${PACKAGES[@]}"; do
    if ! run stow -d "$DOTFILES" -t "$HOME" -R "$pkg"; then
        echo "Could not link '$pkg': a real file is in the way (see the message above)." >&2
        echo "Move it aside, for example: mv ~/.config/$pkg ~/.config/$pkg.bak, then re-run." >&2
        exit 1
    fi
done

if [ "$OS" = macos ]; then
    # Make the iTerm profile from this repo the default one. Restart iTerm to see it.
    ITERM_PROFILE="$DOTFILES/iterm/Library/Application Support/iTerm2/DynamicProfiles/cactus.json"
    ITERM_GUID="$(plutil -extract Profiles.0.Guid raw -o - "$ITERM_PROFILE")"
    log "Setting the iTerm default profile"
    run defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "$ITERM_GUID"
fi

if [ "$PLUGINS" = 1 ]; then
    log "Installing plugins"
    clone() { if [ ! -d "$2/.git" ]; then run git clone --depth 1 "$1" "$2"; fi; }
    P="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins"
    clone https://github.com/Aloxaf/fzf-tab "$P/fzf-tab"
    clone https://github.com/jeffreytse/zsh-vi-mode "$P/zsh-vi-mode"
    clone https://github.com/zsh-users/zsh-autosuggestions "$P/zsh-autosuggestions"
    clone https://github.com/zsh-users/zsh-syntax-highlighting "$P/zsh-syntax-highlighting"
    # tmux plugins: every `set -g @plugin 'owner/name'` line in tmux.conf (this includes tpm itself)
    TMUX_PLUGINS="${XDG_DATA_HOME:-$HOME/.local/share}/tmux/plugins"
    while IFS= read -r repo; do
        clone "https://github.com/$repo" "$TMUX_PLUGINS/$(basename "$repo")"
    done < <(sed -n "s/^set -g @plugin '\([^']*\)'.*/\1/p" "$DOTFILES/tmux/.config/tmux/tmux.conf")
    # Git aliases (gst, ga, gco, ...) come from the oh-my-zsh git plugin; fetch only what it needs
    if [ ! -d "$P/ohmyzsh/.git" ]; then
        run git clone -q --depth 1 --filter=blob:none --sparse https://github.com/ohmyzsh/ohmyzsh "$P/ohmyzsh"
        run git -C "$P/ohmyzsh" sparse-checkout set --no-cone /lib/git.zsh /plugins/git/
    fi
fi

if [ "$FONTS" = 1 ]; then
    case $OS in
        linux)
            FONT_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/fonts/FiraCodeNerdFont"
            if [ ! -d "$FONT_DIR" ]; then
                log "Installing FiraCode Nerd Font"
                run mkdir -p "$FONT_DIR"
                FONT_ZIP="$(mktemp)"
                run curl -fsSL -o "$FONT_ZIP" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
                run unzip -qo "$FONT_ZIP" -d "$FONT_DIR"
                run rm -f "$FONT_ZIP"
                run fc-cache -f "$FONT_DIR"
            fi
            ;;
        wsl)
            log "Font: Windows Terminal needs FiraCode Nerd Font installed on the Windows side (see README)" ;;
    esac
fi

cat <<EOF

Done. Next steps:
  - Machine-specific config goes in ~/work/config/zsh (shell) and ~/work/config/.gitconfig (git identity, signing)
  - Make zsh your default shell if it isn't:  chsh -s "\$(command -v zsh)"
EOF

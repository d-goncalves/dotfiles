#!/usr/bin/env bash
# Sets up this machine: tools (Homebrew), config links (stow) and plugins.
# Works on macOS, Linux and WSL. Safe to re-run.
set -euo pipefail

usage() {
    cat <<'EOF'
Usage: ./bootstrap.sh [options]

  --extras       also install Brewfile.extras (homelab tools and so on)
  --no-brew      skip Homebrew; link configs only (for machines without admin rights)
  --no-plugins   skip cloning zsh and tmux plugins
  --dry-run      print what would happen, change nothing
  -h, --help     show this help
EOF
}

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXTRAS=0 BREW=1 PLUGINS=1 DRY=0
for arg in "$@"; do
    case $arg in
        --extras) EXTRAS=1 ;;
        --no-brew) BREW=0 ;;
        --no-plugins) PLUGINS=0 ;;
        --dry-run) DRY=1 ;;
        -h | --help) usage; exit 0 ;;
        *) echo "Unknown option: $arg" >&2; usage >&2; exit 1 ;;
    esac
done

log() { printf '\n==> %s\n' "$*"; }
run() {
    if [ "$DRY" = 1 ]; then echo "+ $*"; else "$@"; fi
}

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
else
    log "Skipping Homebrew. Install the tools listed in Brewfile yourself."
fi

log "Linking configs with stow"
if ! command -v stow >/dev/null 2>&1 && [ "$DRY" = 0 ]; then
    echo "stow not found. Install it (brew install stow, or apt install stow) and re-run." >&2
    exit 1
fi
PACKAGES=(zsh git tmux nvim alacritty)
if command -v sway >/dev/null 2>&1; then PACKAGES+=(linux-desktop); fi
run mkdir -p "$HOME/.config" "$HOME/.local/state/zsh"   # stops stow from linking the whole ~/.config
for pkg in "${PACKAGES[@]}"; do
    if ! run stow -d "$DOTFILES" -t "$HOME" -R "$pkg"; then
        echo "Could not link '$pkg': a real file is in the way (see the message above)." >&2
        echo "Move it aside, for example: mv ~/.config/$pkg ~/.config/$pkg.bak, then re-run." >&2
        exit 1
    fi
done

if [ "$PLUGINS" = 1 ]; then
    log "Installing plugins"
    clone() { if [ ! -d "$2/.git" ]; then run git clone --depth 1 "$1" "$2"; fi; }
    P="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins"
    clone https://github.com/Aloxaf/fzf-tab "$P/fzf-tab"
    clone https://github.com/jeffreytse/zsh-vi-mode "$P/zsh-vi-mode"
    clone https://github.com/zsh-users/zsh-autosuggestions "$P/zsh-autosuggestions"
    clone https://github.com/zsh-users/zsh-syntax-highlighting "$P/zsh-syntax-highlighting"
    clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

cat <<EOF

Done. Next steps:
  - Machine-specific config goes in ~/work/.zsh (shell) and ~/work/.gitconfig (git identity, signing)
  - Make zsh your default shell if it isn't:  chsh -s "\$(command -v zsh)"
  - In tmux, press prefix + I once to install its plugins
EOF

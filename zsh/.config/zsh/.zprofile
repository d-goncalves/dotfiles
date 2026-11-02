# Homebrew: macOS (Apple Silicon / Intel) or Linuxbrew on Linux and WSL, when installed
for brew in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew "$HOME/.linuxbrew/bin/brew"; do
    if [[ -x $brew ]]; then
        eval "$("$brew" shellenv)"
        break
    fi
done

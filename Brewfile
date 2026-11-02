# Core tools, installed everywhere (macOS, Linux, WSL) with Homebrew.
# Install with: brew bundle --file=Brewfile   (bootstrap.sh does this for you)
brew "stow"
brew "git"
brew "gh"
brew "zsh" if OS.linux?
brew "neovim"
brew "tmux"
brew "fzf"
brew "starship"
brew "tree-sitter-cli"   # nvim-treesitter builds its parsers with it (needs a C compiler too)
brew "ripgrep"
brew "fd"
brew "bat"
brew "eza"
brew "tree"
brew "jq"
brew "direnv"
brew "jump"
brew "node"
brew "wget"
brew "htop"

# Terminal font (Linux gets it from bootstrap.sh; Windows needs it installed on the Windows side)
cask "font-fira-code-nerd-font" if OS.mac?

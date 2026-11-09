# Core tools, installed everywhere (macOS, Linux, WSL) with Homebrew.
# Install with: brew bundle --file=Brewfile   (bootstrap.sh does this for you)
brew "stow"
brew "git"
brew "gh"
brew "git-delta"         # git pager; git falls back to less when it is missing
brew "zsh" if OS.linux?
brew "neovim"
brew "tmux"
brew "fzf"
brew "starship"
brew "zoxide"            # `j` to jump to directories you use often
brew "direnv"
brew "tree-sitter-cli"   # nvim-treesitter builds its parsers with it (needs a C compiler too)
brew "ripgrep"
brew "fd"
brew "bat"
brew "eza"
brew "tree"
brew "jq"
brew "btop"
brew "htop"
brew "lazygit"
brew "wget"
brew "node"              # copilot.vim and several language servers run on it
brew "uv"                # python tooling
brew "rustup"            # rust toolchain; bootstrap.sh installs the stable one

# Terminal font (Linux gets it from bootstrap.sh; Windows needs it installed on the Windows side)
cask "font-jetbrains-mono-nerd-font" if OS.mac?

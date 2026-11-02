# Language servers for nvim. Install with: ./bootstrap.sh --lsp
# nvim only enables a server when it is installed, so install just what you use.
# Not in Homebrew: nil (nix) and tflint. clangd comes with the Xcode command line tools
# on macOS and with the clang or clangd package on Linux.
brew "bash-language-server"
brew "dhall-lsp-server"
brew "docker-compose-langserver"
brew "lua-language-server"
brew "pyright"
brew "python-lsp-server"
brew "rust-analyzer"
brew "terraform-ls"
brew "ty"
brew "typescript-language-server"
brew "typos-lsp"
brew "yaml-language-server"

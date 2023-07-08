[#](#) NeoVim configuration files

Description of my current dotfiles, how to install it and next things comming

## General configuration

Current OS: Ubuntu 20.04
Try: EndeavourOS

## Neovim themes

*   [TokyoNight](https://github.com/ghifarit53/tokyonight-vim)
*   [Vscode](https://github.com/Mofiqul/vscode.nvim)
*   [OneDarkPro](https://github.com/olimorris/onedarkpro.nvim)
*   [Edge](https://github.com/sainnhe/edge)
*   [OneDark Nvim](https://github.com/navarasu/onedark.nvim)
*   [EverBlush](https://github.com/Everblush/everblush.vim)
*   [One Monokai](https://github.com/cpea2506/one_monokai.nvim)
*   [Kanagawa](https://github.com/rebelot/kanagawa.nvim)
*   [Oceanic Next](https://github.com/mhartington/oceanic-next)
*   [Sonokai](https://github.com/sainnhe/sonokai)
*   [OneHalf](https://github.com/sonph/onehalf)
*   [XCode](https://github.com/arzg/vim-colors-xcode)
*   [Hybrid Material](https://github.com/kristijanhusak/vim-hybrid-material)

## Tools used

*   [Neovim](neovim.io)
*   FZF
*   tmux
*   tmuxinator
*   zsh
*   alacritty

## Theme

*   \[X] [srcery-colors](https://srcery-colors.github.io/)

## Fonts

[Download fonts](https://www.nerdfonts.com/font-downloads)

*   \[ ] [Sarasa-Gothic](https://github.com/be5invis/Sarasa-Gothic)
*   \[ ] [Hasklig](https://github.com/i-tu/Hasklig)
*   \[ ] [FiraCode](https://github.com/tonsky/FiraCode)
*   \[ ] [Hack](https://github.com/source-foundry/Hack)
*   \[X] [MesloLGS NF](https://github.com/romkatv/dotfiles-public/blob/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Regular.ttf)

## Installation

1.  Install Neovim, tmux, zsh and alacritty.
2.  Install gnu/stow:.
3.  Get inside neovim, run `:checkhealth` and install node, python and ruby (optional but recommended).
4.  Clone the repo into the $HOME repository ideally.
5.  Inside ~/dotfiles/ run: `stow nvim`, `stow tmux`, `stow zsh`, \`stow alacrity **NOTE:** this will replace already existing dotfiles.
6.  Go to and run `~/.zsh/install.sh`.
7.  There might be some more dependencies like vim-plug, coc.nvim and fzf.nvim. This will be dealt with a plugin in the future.

<!---->

    sudo apt install zsh

    sudo apt install neovim

    sudo apt install tmux

    sudo apt install tmuxinator

    pip3 install pynvim

    sudo apt install nodejs

    install tpm tmux

    chsh -s $(which zsh)

### Browser extenstion

*   \[ ] Browser Extension
*   \[ ] I don't care about cookies
*   \[ ] Panorama Tab Groups
*   \[ ] Refined Bitbucket
*   \[ ] uBlock Origin
*   \[ ] Unhook - remove youtube recommended videos
*   \[ ] Vimium
*   \[ ] Youtube Playback Speed Control
*   \[ ] Disconnect
*   \[ ] Dark Reader
*   \[ ] Grammarly

## TODO

*   \[ ] Installation script (for diferent OS).
*   \[ ] Redo the configuration inside of desktop, still needs clean

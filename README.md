# NeoVim configuration files

Description of my current dotfiles, how to install it and next things comming

## General configuration

Current OS: Ubuntu 20.04
Try: EndeavourOS

#### Tools used:
 - [Neovim](neovim.io)
 - FZF
 - tmux
 - tmuxinator
 - zsh
 - alacritty

#### Theme:
 - [X] [srcery-colors](https://srcery-colors.github.io/)


#### Fonts:

 - [ ] [Sarasa-Gothic](https://github.com/be5invis/Sarasa-Gothic)
 - [ ] [Hasklig](https://github.com/i-tu/Hasklig)
 - [ ] [FiraCode](https://github.com/tonsky/FiraCode)
 - [ ] [Hack](https://github.com/source-foundry/Hack)
 - [X] [MesloLGS NF](https://github.com/romkatv/dotfiles-public/blob/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Regular.ttf)
## Installation

1. Install Neovim, tmux, zsh and alacritty.
1. Install gnu/stow.
1. Get inside neovim, run `:checkhealth` and install node, python and ruby (optional but recommended).
1. Clone the repo into the $HOME repository ideally.
1. Inside ~/dotfiles/ run: `stow nvim`, `stow tmux`, `stow zsh`, `stow alacritty` **NOTE:** this will replace already existing dotfiles.
1. Go to and run `~/.zsh/install.sh`.
1. There might be some more dependencies like vim-plug, coc.nvim and fzf.nvim. This will be dealt with a plugin in the future.
1.
```
sudo apt install zsh

sudo apt install neovim

sudo apt install tmux

sudo apt install tmuxinator

pip3 install pynvim

sudo apt install nodejs

install tpm tmux

chsh -s $(which zsh)
```

#### Browser configuration:
1. Install browser extenstion
    - [ ] Browser Extension
    - [ ] I don't care about cookies
    - [ ] Panorama Tab Groups
    - [ ] Refined Bitbucket
    - [ ] uBlock Origin
    - [ ] Unhook - remove youtube recommended videos
    - [ ] Vimium
    - [ ] Youtube Playback Speed Control
    - [ ] Disconnect
    - [ ] Dark Reader
    - [ ] Grammarly

## TODO

 - [ ] Installation script (for diferent OS).
 - [ ] Redo the configuration inside of desktop, still needs to be cleaned up

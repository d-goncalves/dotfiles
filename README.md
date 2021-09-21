# NeoVim configuration files

Description of my current dotfiles, how to install it and next things comming

## General configuration

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

## TODO

 - [ ] Installation script (for diferent OS).
 - [ ] Create a script to change theme of all tools with a single command.
    - [ ] This can be done with Xargs.
 - [ ] Create a script to change the font.

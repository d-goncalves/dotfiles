# NeoVim configuration files

Description of my current dotfiles, how to install it and next things comming

## General configuration

#### Tools used:
 - [Neovim](neovim.io)
 - FZF
 - tmux
 - zsh
 - alacritty

#### Theme:
 - [X] [srcery-colors](https://srcery-colors.github.io/)


#### Fonts:

 - [ ] [Sarasa-Gothic](https://github.com/be5invis/Sarasa-Gothic)
 - [ ] [Hasklig](https://github.com/i-tu/Hasklig)
 - [ ] [FiraCode](https://github.com/tonsky/FiraCode)
 - [ ] [Hack](https://github.com/source-foundry/Hack)
 - [x] [MesloLGS NF](https://github.com/romkatv/dotfiles-public/blob/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Regular.ttf)


#### Generate ASCII:

[ASCI](http://patorjk.com/software/taag/)
\
FONT: eletronic

## Installation

1. Install Neovim, tmux, zsh and alacritty.
1. Install gnu/stow.
1. Get inside neovim, run `:checkhealth` and install node, python and ruby (optional but recommended).
1. Clone the repo into the $HOME repository ideally.
1. Inside ~/dotfiles/ run: `stow nvim`, `stow tmux`, `stow zsh`, `stow alacritty` **NOTE:** this will replace already existing dotfiles.
1. Go to and run `~/.zsh/install.sh`.
1. There might be some more dependencies like vim-plug, coc.nvim and fzf.nvim. This will be dealt with a plugin in the future.


## Neovim

```
nvim
|--- general
     |--- main.vim
     |--- settings.vim
|--- keys
     |--- main.vim
     |--- mappings.vim
     |--- which-key.vim
|--- plug-config
     |--- coc.vim
     |--- firenvim.vim
     |--- fzf.vim    
     |--- main.vim  
     |--- markdow-preview.vim
     |--- nvim-colorizer-lua.vim
     |--- start-screen.vim     
     |--- switch.vim          
     |--- ultisnips.vim      
|--- snips
     |--- tex.snippets
|--- themes
     |--- airline.vim
     |--- main.vim
|--- init.vim
```

#### General
Subdivided into main and settings.vim. The idea is that main.vim will submanage the folder and settings.vim will contain all the information about the general neovim configuration. This like `set cmdheigh=1` or `set nobackup` will always and only be here

#### Keys
Subdivided into main, mappings and which-key.

- main.vim -> will only manage the subfolder.

- Mappings.nvim -> will contain all the mappings manually added to the neovim configuration. All the mappings will only be here in order to make it quick to change and identify any problem with any mapping conflict.

- Which-key.vim -> will use the plugin which-key, it will display all the mappings associated with the leader key after pressing it and waiting half a second.

#### Plug-config
Once again main contains organizes the folder itself but every file contains the configuration of the plugin of its name. For example the coc.nvim plugin will have all its configuration on the coc.vim file. **NOTE:** The mappings are not done here! they are done on ``Keys/mappings.vim``

#### Snips
This folder will contain all the custom made snippets. The name of the file must always be {extension}.snippets (e.g tex.snippets).

#### Themes
Subdivided into main and airline.
- main.vim -> contains everything theme related like `set termguicolors` and `colorscheme`. **NOTE:** if you want to check themes out, instead of always change the colorscheme use `:Colors` instead.

- airline.vim -> Contains the general visual settings of airline, like choosing the theme.

#### init.vim
Init.vim is the main file and it also is where all the plugins are being managed along side with vim-plug. It is also where everyout subfolder main is being sourced from. Be carefull the order in which the files are sourced matters duo to remapping of keys.

## Tmux

Contains only the .tmux.conf file with general configuration usage.

Simple keybindings to start using:
```
C-? means control followed by ?

C-a -> prefix
C-r -> refresh source
C-c -> new window
C-n -> next window
C-p -> previous window
C-l -> last window
C-s -> choose session
C-w -> choose window
C-k -> Kill window
```

## ZSH

```
zsh
|--- .zshrc
|--- .zsh
     |--- aliasrc
     |--- install.sh
```

**.zshrc** - Contains the general settings for the shell, including importing the plugins.
\
**.zsh/aliasrc** - Contains all the alias used in the shell (e.g. gst -> git status).
\
**.zsh/install.sh** - A simple plugin manager that will check if the plugins are installed, if so update them, if not clone the plugins.

## TODO

 - [ ] Installation script (for diferent OS).
 - [ ] Create OS independent dotfiles (e.g. `ls` alias are ubuntu only).
 - [ ] Create a script to change theme of all tools with a single command.
 - [ ] Create a script to change the font.
 - [ ] On `.zsh` create a script folder with some of existing plugins in them.
 - [ ] Test and improve the usage of scripts.
 - [ ] Add alacritty settings

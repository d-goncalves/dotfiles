" Plugins

set encoding=UTF-8

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Language support
    Plug 'sheerun/vim-polyglot'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " FuzzyFinder
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'    " Fzf integration
    Plug 'airblade/vim-rooter' " Changes vim working directory to the project
    Plug 'romainl/vim-cool'    " When using find with / after moving disable highlight

    " User friendly
    Plug 'liuchengxu/vim-which-key' " Press the leader <SPACE> to show all the available commands TODO: Configure it
    Plug 'mhinz/vim-startify'       " Project start menu with cowsay

    " Visual Upgrades
    Plug 'ryanoasis/vim-devicons'      " Icons
    Plug 'norcalli/nvim-colorizer.lua' " Confure for color codes to be displayed with real colors #412 #000 #fff
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
    " Themes
    "Plug 'ajmwagar/vim-deus'
    "Plug 'aradunovic/perun.vim'
    "Plug 'ayu-theme/ayu-vim'
    "Plug 'b4skyx/serenade'
    "Plug 'jdsimcoe/abstract.vim'
    "Plug 'lithammer/vim-eighties'
    "Plug 'marciomazza/vim-brogrammer-theme'
    "Plug 'mhartington/oceanic-next'
    "Plug 'sainnhe/forest-night'
    "Plug 'srushti/my.vim'
    "Plug 'vim-scripts/wombat256.vim'
    Plug 'morhetz/gruvbox'             " Gruvbox theme
    Plug 'srcery-colors/srcery-vim'
    Plug 'sainnhe/edge'
    Plug 'chriskempson/base16-vim'
    Plug 'rktjmp/lush.nvim'

    " Usability
    Plug 'AndrewRadev/switch.vim'         " TODO: configure this, dictionary of antonyms (e.g. True <-> False)
    Plug 'scrooloose/nerdcommenter'       " Commenting with leader key (e.g. <leader> c <space>)
    Plug 'tpope/vim-surround'             " Change surroudings of a word
    Plug 'terryma/vim-multiple-cursors'
    Plug 'markonm/traces.vim'

    " Online dictionary
    " NOTE: Not working because of legal issues / Find alternative
    "Plug 'beloglazov/vim-online-thesaurus' " Online dictionary

    " Tmux and terminal integration
    Plug 'wincent/terminus'               " Increase mouse integration between Terminal, Tmux and Vim
    Plug 'christoomey/vim-tmux-navigator' " Use ctrl + hjkl to change pane
    Plug 'tmux-plugins/vim-tmux-focus-events'

    " Auto pair, Close and finish. Prefer vim-closer but conflicts with COC
    Plug 'jiangmiao/auto-pairs'

    " Snips
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

    " HTML
    Plug 'mattn/emmet-vim'

    " Get nvim on the browser
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

    " Git configuration
    Plug 'airblade/vim-gitgutter' " Add git diff on the left side
    Plug 'tpope/vim-fugitive'     " Git for vim

    " Markdown
    Plug 'plasticboy/vim-markdown'
    Plug 'godlygeek/tabular'

    " Show Trailing Whitespace
    Plug 'vim-scripts/ShowTrailingWhitespace'

    Plug 'editorconfig/editorconfig-vim'

    "Plug 'liuchengxu/vista.vim'
call plug#end()

" Source everything
source $HOME/.config/nvim/plug-config/main.vim
source $HOME/.config/nvim/themes/main.vim
source $HOME/.config/nvim/general/main.vim
source $HOME/.config/nvim/keys/main.vim

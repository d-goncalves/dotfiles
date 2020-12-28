


""""""""""""""""""""""""""""""""""""""
"  ____  _             _
" |  _ \| |_   _  __ _(_)_ __  ___
" | |_) | | | | |/ _` | | '_ \/ __|
" |  __/| | |_| | (_| | | | | \__ \
" |_|   |_|\__,_|\__, |_|_| |_|___/
"                |___/
""""""""""""""""""""""""""""""""""""""

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    "" Icons
    Plug 'ryanoasis/vim-devicons'
    " Language support
    Plug 'sheerun/vim-polyglot'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}    

    Plug 'mattn/emmet-vim'

    " Vim Airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " FuzzyFinder
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-rooter'

    Plug 'tmux-plugins/vim-tmux-focus-events'
    " Startify
    Plug 'mhinz/vim-startify'

    " Which key
    Plug 'liuchengxu/vim-which-key'

    " Visual Upgrades (aka Themes and colors)
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'joshdick/onedark.vim'
    Plug 'chriskempson/base16-vim' " Theme
    Plug 'tomasiser/vim-code-dark' " Another Theme
    Plug 'arcticicestudio/nord-vim'
    Plug 'rakr/vim-one'
    
    " Usability
    Plug 'tpope/vim-surround'             " Change surroudings of a word
    Plug 'christoomey/vim-tmux-navigator' " Use ctrl + hjkl to change pane
    " Plug 'rstacruz/vim-closer'
    Plug 'wincent/terminus'               " Increase mouse integration between Terminal, Tmux and Vim
    Plug 'unblevable/quick-scope' " Highlight a letter in every word to use f _
    Plug 'AndrewRadev/switch.vim'
    Plug 'scrooloose/nerdcommenter'       " Commenting with leader key
    "Plug 'ervandew/supertab'              " When click tab insert completion
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'liuchengxu/vista.vim'
    Plug 'terryma/vim-multiple-cursors'
    " Snips 
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

    "" Git configuration
    Plug 'airblade/vim-gitgutter' " Add git diff on the left side
    Plug 'tpope/vim-fugitive'     " Git for vim
    
    Plug 'editorconfig/editorconfig-vim'
call plug#end()

set encoding=UTF-8

"let mapleader = "\<Space>"
"
""" Font
"" https://github.com/i-tu/Hasklig
"" https://github.com/tonsky/FiraCode (Current)
"" https://github.com/source-foundry/Hack
"
" let base16colorspace=256
" set termguicolors
"
" colorscheme base16-ocean
"" colorscheme base16-mocha
" colorscheme codedark
"
""""""""""""""""""""""""""""""""""""""
"  ____
" / ___|  ___  _   _ _ __ ___ ___
" \___ \ / _ \| | | | '__/ __/ _ \
"  ___) | (_) | |_| | | | (_|  __/
" |____/ \___/ \__,_|_|  \___\___|
"
""""""""""""""""""""""""""""""""""""""

source $HOME/.config/nvim/general/main.vim
source $HOME/.config/nvim/plug-config/main.vim
source $HOME/.config/nvim/keys/main.vim
source $HOME/.config/nvim/themes/main.vim


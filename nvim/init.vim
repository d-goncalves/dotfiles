" ▄▄▄▄▄▄▄▄▄▄▄  ▄            ▄         ▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄        ▄  ▄▄▄▄▄▄▄▄▄▄▄ 
"▐░░░░░░░░░░░▌▐░▌          ▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░▌      ▐░▌▐░░░░░░░░░░░▌
"▐░█▀▀▀▀▀▀▀█░▌▐░▌          ▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀▀▀  ▀▀▀▀█░█▀▀▀▀ ▐░▌░▌     ▐░▌▐░█▀▀▀▀▀▀▀▀▀ 
"▐░▌       ▐░▌▐░▌          ▐░▌       ▐░▌▐░▌               ▐░▌     ▐░▌▐░▌    ▐░▌▐░▌          
"▐░█▄▄▄▄▄▄▄█░▌▐░▌          ▐░▌       ▐░▌▐░▌ ▄▄▄▄▄▄▄▄      ▐░▌     ▐░▌ ▐░▌   ▐░▌▐░█▄▄▄▄▄▄▄▄▄ 
"▐░░░░░░░░░░░▌▐░▌          ▐░▌       ▐░▌▐░▌▐░░░░░░░░▌     ▐░▌     ▐░▌  ▐░▌  ▐░▌▐░░░░░░░░░░░▌
"▐░█▀▀▀▀▀▀▀▀▀ ▐░▌          ▐░▌       ▐░▌▐░▌ ▀▀▀▀▀▀█░▌     ▐░▌     ▐░▌   ▐░▌ ▐░▌ ▀▀▀▀▀▀▀▀▀█░▌
"▐░▌          ▐░▌          ▐░▌       ▐░▌▐░▌       ▐░▌     ▐░▌     ▐░▌    ▐░▌▐░▌          ▐░▌
"▐░▌          ▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌ ▄▄▄▄█░█▄▄▄▄ ▐░▌     ▐░▐░▌ ▄▄▄▄▄▄▄▄▄█░▌
"▐░▌          ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌      ▐░░▌▐░░░░░░░░░░░▌
" ▀            ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀        ▀▀  ▀▀▀▀▀▀▀▀▀▀▀ 

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
    Plug 'romainl/vim-cool'

    Plug 'tmux-plugins/vim-tmux-focus-events'
    " Startify
    Plug 'mhinz/vim-startify'

    " Which key
    Plug 'liuchengxu/vim-which-key'

    " Visual Upgrades (aka Themes and colors)
    Plug 'norcalli/nvim-colorizer.lua' " This doesn't work, still needs more configuration, do it when switching to nvim 0.5
    Plug 'chriskempson/base16-vim' " Theme
    
    " Usability
    Plug 'tpope/vim-surround'             " Change surroudings of a word
    Plug 'christoomey/vim-tmux-navigator' " Use ctrl + hjkl to change pane
    Plug 'wincent/terminus'               " Increase mouse integration between Terminal, Tmux and Vim
    Plug 'unblevable/quick-scope' " Highlight a letter in every word to use f _
    Plug 'AndrewRadev/switch.vim'
    Plug 'scrooloose/nerdcommenter'       " Commenting with leader key
    "Plug 'ervandew/supertab'              " When click tab insert completion
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'liuchengxu/vista.vim'
    Plug 'terryma/vim-multiple-cursors'

    " Auto pair, Close and finish.
    " Prefer vim-closer but conflicts with COC
    Plug 'jiangmiao/auto-pairs'
    " Plug 'rstacruz/vim-closer'

    " Snips 
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

    "" Git configuration
    Plug 'airblade/vim-gitgutter' " Add git diff on the left side
    Plug 'tpope/vim-fugitive'     " Git for vim
    
    Plug 'editorconfig/editorconfig-vim'
call plug#end()

set encoding=UTF-8

" ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄         ▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄ 
"▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌
"▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀▀▀ 
"▐░▌          ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░▌          ▐░▌          
"▐░█▄▄▄▄▄▄▄▄▄ ▐░▌       ▐░▌▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄█░▌▐░▌          ▐░█▄▄▄▄▄▄▄▄▄ 
"▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░▌          ▐░░░░░░░░░░░▌
" ▀▀▀▀▀▀▀▀▀█░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░█▀▀▀▀█░█▀▀ ▐░▌          ▐░█▀▀▀▀▀▀▀▀▀ 
"          ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░▌     ▐░▌  ▐░▌          ▐░▌          
" ▄▄▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌▐░▌      ▐░▌ ▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄▄▄ 
"▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌
" ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀         ▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀ 
                                                                              
source $HOME/.config/nvim/general/main.vim
source $HOME/.config/nvim/plug-config/main.vim
source $HOME/.config/nvim/keys/main.vim
source $HOME/.config/nvim/themes/main.vim


" Font
" https://github.com/i-tu/Hasklig
" https://github.com/tonsky/FiraCode (Current)
" https://github.com/source-foundry/Hack

" Generate ASCII
" SOURCE: http://patorjk.com/software/taag/
" FONT: eletronic

" ==================================================================
" PLUGINS
" ==================================================================

call plug#begin()

" Snips
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'chriskempson/base16-vim' " Theme
Plug 'scrooloose/nerdtree' " A Tree explorer
Plug 'majutsushi/tagbar' " Display file's current Tree
Plug 'tpope/vim-fugitive' " Git for vim
Plug 'tpope/vim-surround' " Change surroudings of a word
Plug 'scrooloose/nerdcommenter' " Commenting with leader key
Plug 'christoomey/vim-tmux-navigator' " Use ctrl + hjkl to change pane
Plug 'jiangmiao/auto-pairs' " Add pair to every Graphical Signal [{(...

" Testing 
Plug 'kien/ctrlp.vim' " Not sure if i will use it


Plug 'wincent/command-t', {
  \   'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make'
  \ }

Plug 'tpope/vim-rvm'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'Shougo/denite.nvim'
Plug 'w0rp/ale'
Plug 'whatyouhide/vim-lengthmatters'
" Plug 'Shougo/deoplete.nvim'
" Plug 'artur-shaik/vim-javacomplete2'

call plug#end()


" ==================================================================
" CORE
" ==================================================================

" Detect filetype and syntax for certain file types
syntax enable
filetype on
colorscheme base16-ocean
set termguicolors
set synmaxcol=200 " Improve performance
set number relativenumber 
set tabstop=4
set shiftwidth=4
set hlsearch
set softtabstop=0
set ignorecase
set smartcase
set incsearch
set cursorline
set nocompatible
set laststatus=1 " Don't really understand this yet

set foldlevelstart=1
set foldmethod=syntax

let mapleader = "\<Space>"

" ==================================================================
" PLUGIN CONFIGURATION
" ==================================================================

" UltiSnips trigger configuration.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical" " UltiSnipsEdit to split window vertically.

" deoplete
let g:deoplete#enable_at_startup = 1

" Tagbar 
nmap <F8> :TagbarToggle<CR>


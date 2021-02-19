" ==================================================================
" PLUGINS
" ==================================================================

call plug#begin()

" Snips 
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'

Plug 'godlygeek/tabular'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'chriskempson/base16-vim' " Theme
Plug 'scrooloose/nerdtree' " A Tree explorer
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'majutsushi/tagbar' " Display file's current Tree
Plug 'tpope/vim-fugitive' " Git for vim
Plug 'tpope/vim-surround' " Change surroudings of a word
Plug 'scrooloose/nerdcommenter' " Commenting with leader key
Plug 'christoomey/vim-tmux-navigator' " Use ctrl + hjkl to change pane
Plug 'jiangmiao/auto-pairs' " Add pair to every Graphical Signal [{(...
Plug 'wincent/terminus'
Plug 'tomasiser/vim-code-dark' " Another Theme

" Testing 
Plug 'kien/ctrlp.vim' " Not sure if i will use it


Plug 'wincent/command-t', { 'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make' }

" Plug 'tpope/vim-rvm'
" Plug 'roxma/vim-hug-neovim-rpc'
" Plug 'Shougo/denite.nvim'
Plug 'w0rp/ale'
" Plug 'whatyouhide/vim-lengthmatters'
" Plug 'artur-shaik/vim-javacomplete2' " Java auto sugestions

Plug '2072/PHP-Indenting-for-VIm'    " PHP indent script
Plug 'Yggdroot/indentLine'           " highlighting 4sp indenting
Plug 'chrisbra/Colorizer'            " colorize colors
Plug 'chriskempson/base16-vim'       " high quality colorschemes
Plug 'mhinz/vim-signify'             " show VCS changes
Plug 'sheerun/vim-polyglot'          " newer language support
"Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'Shougo/deoplete.nvim'          " async completion
Plug 'roxma/nvim-yarp'               " deoplete dependency
"Plug 'roxma/vim-hug-neovim-rpc'      " deoplete dependency Other Features
Plug 'mileszs/ack.vim'               " ack/rg support
Plug 'mattn/emmet-vim'               " emmet support
Plug 'editorconfig/editorconfig-vim' " editorconfig support



call plug#end()


" ==================================================================
" CORE
" ==================================================================

" Detect filetype and syntax for certain file types
syntax enable
filetype plugin indent on
" colorscheme base16-ocean
" colorscheme base16-mocha
colorscheme codedark
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

set title

set foldlevelstart=1
set foldmethod=syntax

let mapleader = "\<Space>"

" ================================================================== PLUGIN CONFIGURATION
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

"autocmd vimenter * NERDTree " Begin nerdTree when vim opens.

set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2


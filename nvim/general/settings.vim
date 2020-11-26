" set leader key
let g:mapleader = "\<Space>"

syntax enable                           " Enables syntax highlighing
filetype plugin indent on
set hidden                              " Required to keep multiple buffers open multiple buffers
set noswapfile                          " No swapfile
set nowrap                              " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler              			            " Show the cursor position all the time
set cmdheight=2                         " More space for displaying messages
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files

" Change tabs for spaces
set tabstop=4                           " Insert 2 spaces for a tab
set shiftwidth=4                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set laststatus=0                        " Always display the status line
set number relativenumber               " Line numbers
set cursorline                          " Enable highlighting of the current line
set background=dark                     " tell vim what the background color looks like
set showtabline=2                       " Always show tabs
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments
set clipboard=unnamedplus               " Copy paste between vim and everything else
"set autochdir                          " Your working directory will always be the same as your working directory

set iskeyword-=_
set iskeyword-=-                      	" treat dash separated words as a word text object"

" You can't stop me
cmap w!! w !sudo tee %

"set synmaxcol=200 " Improve performance
"set number relativenumber 
"set tabstop=4
"set shiftwidth=4
"set hlsearch
"set softtabstop=0
"set ignorecase
"set smartcase
"set incsearch
"set cursorline
"set nocompatible
"set encoding=UTF-8
"set laststatus=1 " Don't really understand this yet
"
"set title
"
"set foldlevelstart=1
"set foldmethod=syntax
"set foldmethod=indent   
"set foldnestmax=10
"set nofoldenable
"set foldlevel=2
"
"set hidden
"set nobackup
"set nowritebackup
"set cmdheight=2
"set updatetime=300
"set shortmess+=c
"if has("patch-8.1.1564")
"  " Recently vim can merge signcolumn and number column into one
"  set signcolumn=number
"else
"  set signcolumn=yes
"endif

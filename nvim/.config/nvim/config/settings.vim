" Settings

" General Types {{{

let g:mapleader = "\<Space>" " set leader key
" set termguicolors
set mouse=a                  " Enable your mouse
set splitbelow               " Horizontal splits will automatically be below
set splitright               " Vertical splits will automatically be to the right
set smartindent              " Makes indenting smart
set autoindent               " Good auto indent
set updatetime=300           " Faster completion
set timeoutlen=500           " By default timeoutlen is 1000 ms
set formatoptions-=cro       " Stop newline continution of comments
set clipboard=unnamedplus    " Copy paste between vim and everything else
set shortmess+=c             " Remove default auto complete prompt
cmap w!! w !sudo tee %

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" Completion menu
" set completeopt=menu,menuone,noselect

" set silent (no beep)
set vb t_vb=".

" }}}
" File Type {{{

syntax enable              " Enables syntax highlighing

filetype on
filetype plugin on
filetype indent on

set encoding=UTF-8         " The encoding displayed
set fileencoding=utf-8     " The encoding written to file
set ffs=unix,dos,mac       " Use Unix as the standard file type

" }}}
" Search {{{

set ignorecase
set smartcase

" }}}
" Tab {{{

set tabstop=4              " Insert 2 spaces for a tab
set shiftwidth=4           " Change the number of space characters inserted for indentation
set smarttab               " Makes tabbing smarter will realize you have 2 vs 4
set expandtab              " Converts tabs to spaces
set softtabstop=0

" }}}
" Buffer {{{

set noswapfile             " No swapfile
set nobackup
set nowritebackup
set undofile

" }}}
" Visual config {{{

set number relativenumber  " Line numbers
set scrolloff=4            " Always leave 4 lines when moving up or down

set showtabline=0          " Disable the top tab line
set laststatus=0           " Never display the status line
set pumheight=10           " Makes popup menu smaller
set colorcolumn=120

set conceallevel=0         " So that I can see `` in markdown files
set cursorline             " Enable highlighting of the current line

highlight clear SignColumn " Change the column on the left to match theme color
highlight clear LineNR     " Remove diferent color from the Git column
highlight ShowTrailingWhitespace ctermbg=Red guibg=Red
autocmd ColorScheme * highlight! link SignColumn LineNr

" }}}
" Folding {{{

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=20

" Settings

let g:mapleader = "\<Space>" " set leader key

set mouse=a                " Enable your mouse
set splitbelow             " Horizontal splits will automatically be below
set splitright             " Vertical splits will automatically be to the right
set smartindent            " Makes indenting smart
set autoindent             " Good auto indent
set updatetime=300         " Faster completion
set timeoutlen=500         " By default timeoutlen is 1000 ms
set formatoptions-=cro     " Stop newline continution of comments
set clipboard=unnamedplus  " Copy paste between vim and everything else
set autochdir              " Your working directory will always be the same as your working directory
set shortmess+=c           " Remove default auto complete prompt
cmap w!! w !sudo tee %
set nocompatible

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" set silent (no beep)
set vb t_vb=".

" File Type {{{
"
syntax enable              " Enables syntax highlighing

filetype plugin on
filetype indent on

set encoding=utf-8         " The encoding displayed
set fileencoding=utf-8     " The encoding written to file
set ffs=unix,dos,mac          " Use Unix as the standard file type

" }}}
" Search {{{

set hlsearch
set ignorecase
set smartcase
set incsearch

" }}}
" Tab {{{

set tabstop=4              " Insert 2 spaces for a tab
set shiftwidth=4           " Change the number of space characters inserted for indentation
set smarttab               " Makes tabbing smarter will realize you have 2 vs 4
set expandtab              " Converts tabs to spaces
set softtabstop=0

" }}}
" Word definition {{{

" set iskeyword+=_           " treat
" set iskeyword+=-           " treat dash separated words as a word text object

" }}}
" Buffer {{{

set hidden                 " Required to keep multiple buffers open multiple buffers
set noswapfile             " No swapfile
set nobackup               " This is recommended by coc
set nowritebackup          " This is recommended by coc
set undofile

" }}}
" Ignore compiled files {{{

set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" }}}
" Visual config {{{

set number relativenumber  " Line numbers
set cmdheight=1            " Reduce command line height size to 1
set scrolloff=4            " Always leave 4 lines when moving up or down

set showtabline=0          " Disable the top tab line
set laststatus=0           " Never display the status line
set pumheight=10           " Makes popup menu smaller
set colorcolumn=120

set conceallevel=0         " So that I can see `` in markdown files
set noshowmode             " We don't need to see things like -- INSERT -- anymore
set wrap                   " Display long lines as just one line
set cursorline             " Enable highlighting of the current line
set ruler                  " Show the cursor position all the time

highlight clear SignColumn " Change the column on the left to match theme color
highlight ShowTrailingWhitespace ctermbg=Red guibg=Red " Display Red for trailling spaces
highlight clear LineNR " Remove diferent color from the Git column
autocmd ColorScheme * highlight! link SignColumn LineNr " In case of no needing the Git column remove it

" }}}

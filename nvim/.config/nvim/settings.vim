" Settings

let g:mapleader = "\<Space>" " set leader key

syntax enable              " Enables syntax highlighing
filetype plugin indent on  " File type specific indentation
set hidden                 " Required to keep multiple buffers open multiple buffers
set noswapfile             " No swapfile
set encoding=utf-8         " The encoding displayed
set pumheight=10           " Makes popup menu smaller
set fileencoding=utf-8     " The encoding written to file
set ruler                  " Show the cursor position all the time
set mouse=a                " Enable your mouse
set splitbelow             " Horizontal splits will automatically be below
set splitright             " Vertical splits will automatically be to the right
set t_Co=256               " Support 256 colors
set conceallevel=0         " So that I can see `` in markdown files
set tabstop=4              " Insert 2 spaces for a tab
set shiftwidth=4           " Change the number of space characters inserted for indentation
set smarttab               " Makes tabbing smarter will realize you have 2 vs 4
set expandtab              " Converts tabs to spaces
set smartindent            " Makes indenting smart
set autoindent             " Good auto indent
set laststatus=0           " Always display the status line
set number relativenumber  " Line numbers
set showtabline=1          " Always show tabs
set noshowmode             " We don't need to see things like -- INSERT -- anymore
set nobackup               " This is recommended by coc
set nowritebackup          " This is recommended by coc
set updatetime=300         " Faster completion
set timeoutlen=500         " By default timeoutlen is 1000 ms
set formatoptions-=cro     " Stop newline continution of comments
set clipboard=unnamedplus  " Copy paste between vim and everything else
set autochdir              " Your working directory will always be the same as your working directory
set scrolloff=4
set colorcolumn=120
set title
set iskeyword+=_
set iskeyword+=-           " treat dash separated words as a word text object                         "
set hlsearch
set softtabstop=0
set ignorecase
set smartcase
set incsearch
set shortmess+=c
cmap w!! w !sudo tee %
set cursorline             " Enable highlighting of the current line
set nocompatible
set cmdheight=1            " Reduce command line height size to 1
highlight clear SignColumn " Change the column on the left to match theme color
set showtabline=0          " Disable the top tab line
set undofile
set wrap                   " Display long lines as just one line

" Fold Settings
set foldmethod=syntax      " Fold method follows syntax specific
"set foldlevelstart=99

highlight ShowTrailingWhitespace ctermbg=Red guibg=Red " Display Red for trailling spaces
highlight clear LineNR " Remove diferent color from the Git column
autocmd ColorScheme * highlight! link SignColumn LineNr " In case of no needing the Git column remove it

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif


" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Use Unix as the standard file type
set ffs=unix,dos,mac

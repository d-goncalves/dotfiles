" Settings

let g:mapleader = "\<Space>" " set leader key

set mouse=a                  " Enable your mouse
set splitbelow
set splitright
set smartindent              " Makes indenting smart
set autoindent               " Good auto indent
set timeoutlen=500           " By default timeoutlen is 1000 ms
set formatoptions-=cro       " Stop newline continution of comments
set clipboard=unnamedplus    " Copy paste between vim and everything else
set shortmess+=c             " Remove default auto complete prompt
cmap w!! w !sudo tee %

" Configure backspace so it acts as it should act
set whichwrap+=h,l " Allow h,l to move to the next line

syntax enable              " Enables syntax highlighting

set ignorecase
set smartcase

set tabstop=4              " Insert 2 spaces for a tab
set shiftwidth=4           " Change the number of space characters inserted for indentation
set smarttab               " Makes tabbing smarter will realize you have 2 vs 4
set expandtab              " Converts tabs to spaces
set softtabstop=0

set noswapfile             " No swapfile
set nobackup
set nowritebackup
set undofile

set number relativenumber  " Line numbers
set scrolloff=4            " Always leave 4 lines when moving up or down

set showtabline=0          " Disable the top tab line
set laststatus=0           " Never display the status line
set pumheight=10           " Makes popup menu smaller
" set colorcolumn=120

set conceallevel=0         " So that I can see `` in markdown files
set cursorline             " Enable highlighting of the current line

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=20

" Mappings

inoremap jk <Esc>
nnoremap <C-c> <Esc>

" Remap VIM 0 to first non-blank character
map 0 ^

" Alternate way to save
nnoremap <C-s> :up<CR>
nnoremap <C-Q> :wq!<CR>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

function! ToggleBlame()
    if &l:filetype ==# 'fugitiveblame'
        close
    else
        Git blame
    endif
endfunction

" Set filetype for yaml.j2 files
au BufRead,BufNewFile *.yml.j2 set ft=yaml.jinja2

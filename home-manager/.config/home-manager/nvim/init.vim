" Plugin manager configuration
let $HOMECONFIG=stdpath('config')

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin(data_dir . 'autoload/plugged')

    " Dependencies
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'kkharji/sqlite.lua'

    " FuzzyFinder
    Plug 'nvim-telescope/telescope.nvim',
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

    " Treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Improved syntax highlighting
    Plug 'romgrk/nvim-treesitter-context'
    Plug 'p00f/nvim-ts-rainbow'

    " LSP
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'jay-babu/mason-null-ls.nvim'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-calc'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
    Plug 'hrsh7th/cmp-nvim-lua'
    Plug 'hrsh7th/cmp-path'
    Plug 'onsails/lspkind.nvim'

    " Git
    Plug 'tpope/vim-fugitive'        " Git for vim
    Plug 'tpope/vim-rhubarb'
    Plug 'lewis6991/gitsigns.nvim'


    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'norcalli/nvim-colorizer.lua'         " Display Color Codes text with color #412 #000 #fff
    Plug 'johnfrankmorgan/whitespace.nvim'
    Plug 'itchyny/vim-cursorword'              " Highlight multiple instances of the same word when hovered
    Plug 'lukas-reineke/indent-blankline.nvim' " Show indentation for blank lines

    " Search
    Plug 'romainl/vim-cool'                    " When using find with / after moving disable highlight
    Plug 'markonm/traces.vim'                  " Find&Replace is shown as it's being done

    " Functional & extend vim
    Plug 'terryma/vim-expand-region'          " Use + to increase object selection, - to decrease selection
    Plug 'tpope/vim-surround'                 " Allow to change surrounds based on text objects
    Plug 'tpope/vim-commentary'               " Comment code with gc
    Plug 'tpope/vim-repeat'                   " Improve support for dot commands
    Plug 'coderifous/textobj-word-column.vim' " Adds column as a text object
    Plug 'andymass/vim-matchup'               " Extends % to jump between functions
    Plug 'wellle/targets.vim'                 " Increase the number of textObjects
    Plug 'AndrewRadev/splitjoin.vim'          " Add gJ and gS split or join multi line texts
    Plug 'junegunn/vim-easy-align'            " With ga allow to align stuff
    Plug 'justinmk/vim-gtfo'                  " Add got and gof

    Plug 'windwp/nvim-autopairs',
    Plug 'AckslD/nvim-neoclip.lua'
    Plug 'ahmedkhalf/project.nvim'
    Plug 'direnv/direnv.vim'

    " Tools
    Plug 'christoomey/vim-tmux-navigator'      " Allow Control hjkl to move between panes
    Plug 'folke/which-key.nvim'
    Plug 'kyazdani42/nvim-tree.lua'

    " Themes
    Plug 'srcery-colors/srcery-vim'
    Plug 'martinsione/darkplus.nvim'
    Plug 'ribru17/bamboo.nvim'
    Plug 'sainnhe/gruvbox-material'
    Plug 'projekt0n/github-nvim-theme'
    Plug 'EdenEast/nightfox.nvim'
    Plug 'rebelot/kanagawa.nvim'
    Plug 'ghifarit53/tokyonight-vim'
    Plug 'tiagovla/tokyodark.nvim'
    Plug 'sainnhe/vim-color-forest-night'
    Plug 'xiyaowong/transparent.nvim'
    Plug 'sainnhe/gruvbox-material'
    Plug 'gruvbox-community/gruvbox'
    Plug 'luisiacc/gruvbox-baby'
call plug#end()

set termguicolors

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
" Source files
"
colorscheme srcery

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
" Source files
source $HOMECONFIG/config/settings.vim
lua require('config.init').setup()

let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_better_performance = 1

colorscheme github_dark

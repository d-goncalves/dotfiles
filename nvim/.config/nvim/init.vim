" NEOVIM Configuration

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
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
    Plug 'AckslD/nvim-neoclip.lua'

    " Treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Improved syntax highlighting
    Plug 'romgrk/nvim-treesitter-context'
    Plug 'p00f/nvim-ts-rainbow'

    " LSP 
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'neovim/nvim-lspconfig' 
    Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'folke/trouble.nvim'

    " Completion Engine
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/cmp-calc'
    Plug 'hrsh7th/cmp-nvim-lua'
    Plug 'onsails/lspkind.nvim'
    Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
    Plug 'folke/lua-dev.nvim'

    " Snippet
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'rafamadriz/friendly-snippets'

    " DAP
    Plug 'mfussenegger/nvim-dap'
    Plug 'theHamsta/nvim-dap-virtual-text'
    Plug 'rcarriga/nvim-dap-ui'
    Plug 'jbyuki/one-small-step-for-vimkind'
    Plug 'mfussenegger/nvim-dap-python'

    " Git
    Plug 'tpope/vim-fugitive'        " Git for vim
    Plug 'lewis6991/gitsigns.nvim'
    " Plug 'akinsho/git-conflict.nvim' " Merge Confict
    " Plug 'sindrets/diffview.nvim'    " Also Merge Conflict

    " Visual
    Plug 'ghifarit53/tokyonight-vim'           " Theme
    Plug 'navarasu/onedark.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'norcalli/nvim-colorizer.lua'         " Display Color Codes text with color #412 #000 #fff
    Plug 'vim-scripts/ShowTrailingWhitespace'  " Show Trailing Whitespace
    Plug 'itchyny/vim-cursorword'              " Highlight multiple instances of the same word when hovered
    Plug 'lukas-reineke/indent-blankline.nvim' " Show indention for blank lines
    Plug 'folke/todo-comments.nvim'

    " Search
    Plug 'romainl/vim-cool'                    " When using find with / after moving disable highlight
    Plug 'markonm/traces.vim'                  " Find&Replace is shown as it's being done
    Plug 'ggandor/lightspeed.nvim'             " Add motion with the s key

    " Functional & extend vim
    Plug 'terryma/vim-expand-region'          " Use + to increase object selection, - to decrease selection
    Plug 'tpope/vim-surround'                 " Allow to change surrounds based on text objects
    Plug 'tpope/vim-commentary'               " Comment code with gc
    Plug 'coderifous/textobj-word-column.vim' " Adds column as a text object
    Plug 'wellle/targets.vim'                 " Increase the number of textObjects
    Plug 'andymass/vim-matchup'               " Extends % to jump between functions
    Plug 'AndrewRadev/splitjoin.vim'          " Add gJ and gS split or join multi line texts
    Plug 'junegunn/vim-easy-align'            " With ga allow to align stuff
    Plug 'tpope/vim-repeat'                   " Improve support for dot commands
    Plug 'jiangmiao/auto-pairs'               " Auto pair, dlose and finish. Prefer vim-closer but conflicts with COC
    Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } } " Generate documenation with <leader>D
    Plug 'ahmedkhalf/project.nvim'
    Plug 'gpanders/editorconfig.nvim'
    Plug 'justinmk/vim-gtfo'
    Plug 'lewis6991/spellsitter.nvim'         " Fix typos
    Plug 'ThePrimeagen/refactoring.nvim'      " Refactor functionalities, such as remove code for a function
    Plug 'ThePrimeagen/harpoon'

    " Tools
    Plug 'christoomey/vim-tmux-navigator'      " Allow Control hjkl to move between panes
    Plug 'vifm/vifm.vim'                       " File manager inside nvim
    Plug 'folke/which-key.nvim'
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

    " Coding challenges
    Plug 'p00f/cphelper.nvim' " Default: `~/contests`
call plug#end()

" Source files
source $HOMECONFIG/config/settings.vim
" source $HOMECONFIG/config/mappings.vim

lua require('config.init').setup()

set termguicolors
" Theme
colorscheme tokyonight
" let g:onedark_config = {
"     \ 'style': 'darker',
" \}
" colorscheme onedark

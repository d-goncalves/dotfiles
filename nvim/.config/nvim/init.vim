" Main

set encoding=UTF-8
<<<<<<< HEAD
=======
set termguicolors
>>>>>>> 416b26048391b9643c06756d7b36475426f3de3f

" Plugin manager configuration {{{

let $HOMECONFIG=stdpath('config')

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" }}}
" Plugins {{{

call plug#begin(data_dir . 'autoload/plugged')

    " Dependencies {{{

    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    " }}}
    " Snippets {{{

    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

    " }}}
    " Dependencies {{{

    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    " }}}
    " FuzzyFinder {{{

    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

    " }}}
    " Language {{{

    Plug 'neovim/nvim-lspconfig' " Collection of configurations for built-in LSP client

<<<<<<< HEAD
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'

    " For luasnip users.
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'

    Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'folke/trouble.nvim'

=======
>>>>>>> 416b26048391b9643c06756d7b36475426f3de3f
    " }}}
    " Tree sitter {{{

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Improved syntax highlighting
    Plug 'romgrk/nvim-treesitter-context'
    Plug 'p00f/nvim-ts-rainbow'

    " }}}
    " Git {{{

    Plug 'tpope/vim-fugitive'      " Git for vim
    Plug 'lewis6991/gitsigns.nvim' " Add git Sign to Version Control changes

    " }}}
    " Themes {{{

    Plug 'sonph/onehalf' , { 'rtp': 'vim' } " Theme
    Plug 'arzg/vim-colors-xcode'            " Xcode theme
    Plug 'ghifarit53/tokyonight-vim'
    " Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
    Plug 'kristijanhusak/vim-hybrid-material'
    Plug 'Mofiqul/vscode.nvim'

    Plug 'olimorris/onedarkpro.nvim'
    Plug 'sainnhe/edge'
    Plug 'Th3Whit3Wolf/one-nvim'
    Plug 'navarasu/onedark.nvim'

    Plug 'Everblush/everblush.vim'
    " }}}
    " Visual Upgrades {{{

    Plug 'ryanoasis/vim-devicons'              " Icons
    Plug 'norcalli/nvim-colorizer.lua'         " Display Color Codes text with color #412 #000 #fff
    Plug 'vim-scripts/ShowTrailingWhitespace'  " Show Trailing Whitespace
    Plug 'itchyny/vim-cursorword'              " Highlight multiple instances of the same word when hovered
    Plug 'lukas-reineke/indent-blankline.nvim' " Show indention for blank lines
    Plug 'folke/todo-comments.nvim'            " Highlight comments
    Plug 'scr1pt0r/crease.vim'                 " Fold text customization

    " }}}
    " Search {{{

    Plug 'romainl/vim-cool'                    " When using find with / after moving disable highlight
    Plug 'markonm/traces.vim'                  " Find&Replace is shown as it's being done
    Plug 'ggandor/lightspeed.nvim'             " Add motion with the s key

    " }}}
    " Functional & extend vim {{{

    Plug 'terryma/vim-expand-region'
    Plug 'tpope/vim-surround'                  " Allow to change surrounds based on text objects
    Plug 'tpope/vim-commentary'                " Comment code with gc
    Plug 'coderifous/textobj-word-column.vim'  " Adds column as a text object
    Plug 'wellle/targets.vim'                  " Increase the number of textObjects
    Plug 'andymass/vim-matchup'                " Extends % to jump between functions
    Plug 'AndrewRadev/splitjoin.vim'           " Add gJ and gS split or join multi line texts
    Plug 'junegunn/vim-easy-align'             " With ga allow to align stuff
    Plug 'tpope/vim-repeat'                    " Improve support for dot commands
    Plug 'ThePrimeagen/refactoring.nvim'       " Refactor functionalities, such as remove code for a function

    " }}}
    " Utils {{{

    Plug 'airblade/vim-rooter'                 " Changes vim working directory to the project
    Plug 'tpope/vim-sleuth'                    " Adjust some configurations based on filetype
    Plug 'editorconfig/editorconfig-vim'       " Editor config configuration

    " }}}
    " Generate Information {{{

    Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } } " Generate documenation with <leader> d
    Plug 'jiangmiao/auto-pairs'                " Auto pair, Close and finish. Prefer vim-closer but conflicts with COC

    " }}}
    " Visual helper {{{

    Plug 'liuchengxu/vim-which-key'            " Using the leader key <space> show some keybinds
    Plug 'mhinz/vim-startify'                  " Project start menu with cowsay
    Plug 'lvim-tech/lvim-helper'               " Keybinds via LvimHelper command
    Plug 'sindrets/diffview.nvim'              " VSCode like git diff

    " }}}
    " External tools {{{

    Plug 'christoomey/vim-tmux-navigator'      " Allow Control hjkl to move between panes
    Plug 'vifm/vifm.vim'                       " File manager inside nvim
    Plug 'vimwiki/vimwiki'                     " Personal wiki space. Used to keep todo list

    " }}}
    " Trial {{{

    Plug 'tpope/vim-unimpaired'                " NOTE: Not using this
    Plug 'michaeljsmith/vim-indent-object'     " NOTE: Not using this
    Plug 'terryma/vim-multiple-cursors'        " NOTE: Not using this
    " Plug 'CRAG666/code_runner.nvim'          " NOTE: This doesn't work quite
    " well yex

    " }}}

    " Plug 'vhdirk/vim-cmake'
call plug#end()

" }}}

set completeopt=menu,menuone,noselect

" Source files {{{

source $HOMECONFIG/plugins/plugin.vim
source $HOMECONFIG/config/settings.vim
source $HOMECONFIG/config/mappings.vim
source $HOMECONFIG/config/filetype.vim
luafile $HOMECONFIG/plugins/plugin.lua

" }}}
"
filetype on

set termguicolors
<<<<<<< HEAD
colorscheme tokyonight

=======

" let g:vscode_style = "dark"
" let g:vscode_transparency = 1
" let g:vscode_italic_comment = 1
" colorscheme vscode

" let g:tokyonight_style = 'night' " available: night, storm
" colorscheme tokyonight
if strftime("%H") < 18
  colorscheme one-nvim
else
  colorscheme onedarkpro
endif
>>>>>>> 416b26048391b9643c06756d7b36475426f3de3f

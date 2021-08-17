" Main

set encoding=UTF-8

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

    " Snippets {{{

    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

    " }}}
    " Language {{{

    Plug 'sheerun/vim-polyglot'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'prettier/vim-prettier', { 'do': 'yarn install' } " Code Format to .prettierrc

    " }}}
    " FuzzyFinder {{{

     Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Install FZF
     Plug 'junegunn/fzf.vim'                             " Fzf integration with vim

    " }}}
    " Dependencies {{{

    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    " }}}
    " Database {{{

    " Usage ':DBUI'
    Plug 'tpope/vim-dadbod'
    Plug 'kristijanhusak/vim-dadbod-completion'
    Plug 'kristijanhusak/vim-dadbod-ui'

    " }}}
    " Tree sitter {{{

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Improved syntax highlighting
    Plug 'romgrk/nvim-treesitter-context'

    " }}}
    " Git {{{

    Plug 'tpope/vim-fugitive'      " Git for vim
    Plug 'lewis6991/gitsigns.nvim' " Add git Sign to Version Control changes

    " }}}
    " Unit Test {{{

    Plug 'vim-test/vim-test'                                     " Vim default test plugin
    Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' } " The ultimate testing plugin for NeoVim

    " }}}
    " Themes {{{

    Plug 'sonph/onehalf' , { 'rtp': 'vim' } " Theme
    Plug 'arzg/vim-colors-xcode'            " Xcode theme

    " }}}

    " TODO: Double check everything here
    " Visual Upgrades {{{

    Plug 'ryanoasis/vim-devicons'              " Icons
    Plug 'norcalli/nvim-colorizer.lua'         " Display Color Codes text with color #412 #000 #fff
    Plug 'romainl/vim-cool'                    " When using find with / after moving disable highlight
    Plug 'AndrewRadev/splitjoin.vim'           " Add gJ and gS split or join multi line texts
    Plug 'vim-scripts/ShowTrailingWhitespace'  " Show Trailing Whitespace
    Plug 'itchyny/vim-cursorword'              " Highlight multiple instances of the same word when hovered
    Plug 'lukas-reineke/indent-blankline.nvim' " Show indention for blank lines
    Plug 'lvim-tech/lvim-helper'               " Keybinds via LvimHelper command
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'terryma/vim-expand-region'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'coderifous/textobj-word-column.vim'  " Adds column as a text object
    Plug 'wellle/targets.vim'                  " Increase the number of textObjects
    Plug 'terryma/vim-multiple-cursors'
    Plug 'sindrets/diffview.nvim'              " VSCode like git diff
    Plug 'markonm/traces.vim'                  " Find&Replace is shown as it's being done
    Plug 'jiangmiao/auto-pairs'                " Auto pair, Close and finish. Prefer vim-closer but conflicts with COC
    Plug 'airblade/vim-rooter'                 " Changes vim working directory to the project
    Plug 'tpope/vim-repeat'                    " Improve support for dot commands
    Plug 'junegunn/vim-easy-align'             " With ga allow to align stuff
    Plug 'kkoomen/vim-doge'                    " Generate documenation with <leader> d
    Plug 'andymass/vim-matchup'                " Extends % to jump between functions
    Plug 'folke/todo-comments.nvim'            " Highlight comments
    Plug 'vimwiki/vimwiki'                     " Personal wiki space. Used to keep todo list
    Plug 'ggandor/lightspeed.nvim'             " Add motion with the s key
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-sleuth'
    Plug 'scr1pt0r/crease.vim'
    Plug 'liuchengxu/vim-which-key' " Using the leader key <space> show some keybinds
    Plug 'mhinz/vim-startify'       " Project start menu with cowsay
    Plug 'vifm/vifm.vim'    " File manager inside nvim

    Plug 'AndrewRadev/switch.vim'       " dictionary of antonyms (e.g. True <-> False)
    Plug 'editorconfig/editorconfig-vim' " Editor config configuration
    Plug 'lvim-tech/lvim-helper'

    " WARN: This plugin is not fully developed yet
    " Still need to add this to which-key
    Plug 'ThePrimeagen/refactoring.nvim' " Refactor functionalities, such as remove code for a function

    " TODO: Configure this if i use HTML
    "Plug 'mattn/emmet-vim'              " Add HTML specific key combinations

    " }}}

call plug#end()

" }}}
" Theme {{{

set termguicolors
set t_Co=256
set t_ut=
colorscheme onehalfdark

" }}}
" Source files {{{

luafile $HOMECONFIG/plugins/plugin.lua
source $HOMECONFIG/plugins/plugin.vim
source $HOMECONFIG/config/settings.vim
source $HOMECONFIG/config/mappings.vim
source $HOMECONFIG/config/filetype.vim

" }}}

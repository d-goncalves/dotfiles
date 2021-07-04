" Plugins

set encoding=UTF-8

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Language support
    Plug 'sheerun/vim-polyglot'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'jackguo380/vim-lsp-cxx-highlight'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

    " FuzzyFinder
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'    " Fzf integration
    Plug 'airblade/vim-rooter' " Changes vim working directory to the project
    Plug 'romainl/vim-cool'    " When using find with / after moving disable highlight

    " User friendly
    Plug 'liuchengxu/vim-which-key' " Press the leader <SPACE> to show all the available commands TODO: Configure it
    Plug 'mhinz/vim-startify'       " Project start menu with cowsay

    " Visual Upgrades
    Plug 'ryanoasis/vim-devicons'      " Icons
    Plug 'norcalli/nvim-colorizer.lua' " Confure for color codes to be displayed with real colors #412 #000 #fff
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
    Plug 'nvim-treesitter/playground'  " Icons

    " Themes
    "Plug 'ajmwagar/vim-deus'
    "Plug 'aradunovic/perun.vim'
    "Plug 'ayu-theme/ayu-vim'
    "Plug 'b4skyx/serenade'
    "Plug 'jdsimcoe/abstract.vim'
    "Plug 'lithammer/vim-eighties'
    "Plug 'marciomazza/vim-brogrammer-theme'
    "Plug 'sainnhe/forest-night'
    "Plug 'srushti/my.vim'
    "Plug 'vim-scripts/wombat256.vim'
    Plug 'mhartington/oceanic-next'
    Plug 'tomasiser/vim-code-dark'
    Plug 'morhetz/gruvbox'             " Gruvbox theme
    Plug 'srcery-colors/srcery-vim'
    Plug 'sainnhe/edge'
    Plug 'chriskempson/base16-vim'
    Plug 'rktjmp/lush.nvim'
    Plug 'Th3Whit3Wolf/one-nvim'
    Plug 'sainnhe/sonokai'

    " Special theme
    " This doesn't seem to work properly
    Plug 'tjdevries/colorbuddy.vim'
    Plug 'tjdevries/gruvbuddy.nvim'
    Plug 'Th3Whit3Wolf/onebuddy'

    " Usability
    Plug 'AndrewRadev/switch.vim'         " TODO: configure this, dictionary of antonyms (e.g. True <-> False)
    Plug 'scrooloose/nerdcommenter'       " Commenting with leader key (e.g. <leader> c <space>)
    Plug 'tpope/vim-surround'             " Change surroudings of a word
    Plug 'terryma/vim-multiple-cursors'
    Plug 'markonm/traces.vim'
    Plug 'yamatsum/nvim-cursorline'

    " Online dictionary
    " NOTE: Not working because of legal issues / Find alternative
    "Plug 'beloglazov/vim-online-thesaurus' " Online dictionary

    " Tmux and terminal integration
    Plug 'wincent/terminus'               " Increase mouse integration between Terminal, Tmux and Vim
    Plug 'christoomey/vim-tmux-navigator' " Use ctrl + hjkl to change pane
    Plug 'tmux-plugins/vim-tmux-focus-events'

    " Auto pair, Close and finish. Prefer vim-closer but conflicts with COC
    Plug 'jiangmiao/auto-pairs'

    " Snips
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

    " HTML
    Plug 'mattn/emmet-vim'

    " Get nvim on the browser
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

    " Git configuration
    Plug 'airblade/vim-gitgutter' " Add git diff on the left side
    Plug 'tpope/vim-fugitive'     " Git for vim

    " Markdown
    Plug 'plasticboy/vim-markdown'
    Plug 'godlygeek/tabular'

    " Database usage
    Plug 'tpope/vim-dadbod'
    Plug 'kristijanhusak/vim-dadbod-ui'

    " Show Trailing Whitespace
    Plug 'vim-scripts/ShowTrailingWhitespace'

    Plug 'editorconfig/editorconfig-vim'

    " Games
    Plug 'ThePrimeagen/vim-be-good' " Requires vim 0.5+
    Plug 'alec-gibson/nvim-tetris'
    Plug 'AndrewRadev/splitjoin.vim'
    "Plug 'liuchengxu/vista.vim'
call plug#end()

" Source everything
source $HOME/.config/nvim/plug-config/main.vim
source $HOME/.config/nvim/general/main.vim
source $HOME/.config/nvim/keys/main.vim

"autcmd vimenter * hi Normal guibg=NONE ctermbg=NONE  " Conflict with nvim-cursorline
highlight clear LineNR
autocmd ColorScheme * highlight! link SignColumn LineNr

lua require'nvim-treesitter.configs'.setup {highlight = { enable = true }}

" Add this improve JEST testing
" TODO: https://github.com/rcarriga/vim-ultest

" Theme configuration
"lua require('colorbuddy').colorscheme('gruvbuddy', 'light')
set termguicolors
colorscheme sonokai

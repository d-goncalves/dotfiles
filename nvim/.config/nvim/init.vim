" Plugins

set encoding=UTF-8

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Language support
    Plug 'sheerun/vim-polyglot'                            " Multiple language syntax support
    Plug 'neoclide/coc.nvim', {'branch': 'release'}        " LSP support
    Plug 'jackguo380/vim-lsp-cxx-highlight'                " cpp language highlight
    Plug 'prettier/vim-prettier', { 'do': 'yarn install' } " Code Format to .prettierrc

    " FuzzyFinder
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Install FZF
    Plug 'junegunn/fzf.vim'                             " Fzf integration with vim

    " User friendly
    Plug 'liuchengxu/vim-which-key' " Using the leader key <space> show some keybinds
    Plug 'mhinz/vim-startify'       " Project start menu with cowsay

    " Visual Upgrades
    Plug 'ryanoasis/vim-devicons'                               " Icons
    Plug 'norcalli/nvim-colorizer.lua'                          " Display Color Codes text with color #412 #000 #fff
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Improved syntax highlighting
    Plug 'nvim-treesitter/playground'                           " Treesitter icons
    Plug 'romainl/vim-cool'                                     " When using find with / after moving disable highlight
    Plug 'AndrewRadev/splitjoin.vim'                            " Add gJ and gS split or join multi line texts
    Plug 'vim-scripts/ShowTrailingWhitespace'                   " Show Trailing Whitespace
    Plug 'itchyny/vim-cursorword'                               " Highlight multiple instances of the same word when hovered
    Plug 'lukas-reineke/indent-blankline.nvim'                  " Show indention for blank lines
    Plug 'Yggdroot/indentLine'                                  " Show line indentation
    Plug 'navarasu/onedark.nvim'                                " Theme

    " Usability
    Plug 'scrooloose/nerdcommenter' " Commenting with leader key (e.g. <leader> c <space>)
    Plug 'markonm/traces.vim'       " Find&Replace is shown as it's being done
    Plug 'jiangmiao/auto-pairs'     " Auto pair, Close and finish. Prefer vim-closer but conflicts with COC
    Plug 'airblade/vim-rooter'      " Changes vim working directory to the project
    Plug 'godlygeek/tabular'        " Use :Tab (e.g :Tab /\" to rearrange comments)

    " Tmux and terminal integration
    Plug 'wincent/terminus'                   " Increase mouse integration between Terminal, Tmux and Vim
    Plug 'christoomey/vim-tmux-navigator'     " Use ctrl + hjkl to change pane
    Plug 'tmux-plugins/vim-tmux-focus-events' " Tmux and vim event focus

    " Git configuration
    Plug 'airblade/vim-gitgutter' " Add git diff on the left side
    Plug 'tpope/vim-fugitive'     " Git for vim

    " Test usage
    Plug 'vim-test/vim-test'                                     " Vim default test plugin
    Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' } " The ultimate testing plugin for NeoVim

    " Snips
    Plug 'SirVer/ultisnips'   " Allos the usage of snippets
    Plug 'honza/vim-snippets' " Already contains comunity snippets

    " Database usage
    Plug 'tpope/vim-dadbod'             " Allow database connect inside vim
    Plug 'kristijanhusak/vim-dadbod-ui' " Improve the database connect visually

    " Usability Inprogress / Enable when needed or interesting in learning
    "Plug 'AndrewRadev/switch.vim'       " TODO: configure this, dictionary of antonyms (e.g. True <-> False)
    "Plug 'tpope/vim-surround'           " Change surroudings of a word
    "Plug 'terryma/vim-multiple-cursors' " Multiple cursor support such as in Sublime text
    "Plug 'mattn/emmet-vim'              " Add HTML specific key combinations
    "Plug 'editorconfig/editorconfig-vim' "Editor config configuration (NOTE: still need to understand this)

    Plug 'plasticboy/vim-markdown'      " Markdown syntax highlight and mappings (NOTE: Must be after tabular !!)
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

    " Todo Plugin || Still choosing it
    "Plug 'vuciv/vim-bujo'
    "Plug 'dhruvasagar/vim-dotoo'
    Plug 'vimwiki/vimwiki'
call plug#end()


" Theme & Visual settings
set termguicolors
lua require'nvim-treesitter.configs'.setup {highlight = { enable = true }}
colorscheme onedark
let g:vimwiki_list = [{'syntax': 'markdown', 'ext':'.md'}]

" Source everything
source $HOME/.config/nvim/plug-config/main.vim
source $HOME/.config/nvim/general/main.vim
source $HOME/.config/nvim/keys/main.vim

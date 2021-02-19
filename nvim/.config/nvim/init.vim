" ▄▄▄▄▄▄▄▄▄▄▄  ▄            ▄         ▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄        ▄  ▄▄▄▄▄▄▄▄▄▄▄ 
"▐░░░░░░░░░░░▌▐░▌          ▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░▌      ▐░▌▐░░░░░░░░░░░▌
"▐░█▀▀▀▀▀▀▀█░▌▐░▌          ▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀▀▀  ▀▀▀▀█░█▀▀▀▀ ▐░▌░▌     ▐░▌▐░█▀▀▀▀▀▀▀▀▀ 
"▐░▌       ▐░▌▐░▌          ▐░▌       ▐░▌▐░▌               ▐░▌     ▐░▌▐░▌    ▐░▌▐░▌          
"▐░█▄▄▄▄▄▄▄█░▌▐░▌          ▐░▌       ▐░▌▐░▌ ▄▄▄▄▄▄▄▄      ▐░▌     ▐░▌ ▐░▌   ▐░▌▐░█▄▄▄▄▄▄▄▄▄ 
"▐░░░░░░░░░░░▌▐░▌          ▐░▌       ▐░▌▐░▌▐░░░░░░░░▌     ▐░▌     ▐░▌  ▐░▌  ▐░▌▐░░░░░░░░░░░▌
"▐░█▀▀▀▀▀▀▀▀▀ ▐░▌          ▐░▌       ▐░▌▐░▌ ▀▀▀▀▀▀█░▌     ▐░▌     ▐░▌   ▐░▌ ▐░▌ ▀▀▀▀▀▀▀▀▀█░▌
"▐░▌          ▐░▌          ▐░▌       ▐░▌▐░▌       ▐░▌     ▐░▌     ▐░▌    ▐░▌▐░▌          ▐░▌
"▐░▌          ▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌ ▄▄▄▄█░█▄▄▄▄ ▐░▌     ▐░▐░▌ ▄▄▄▄▄▄▄▄▄█░▌
"▐░▌          ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌      ▐░░▌▐░░░░░░░░░░░▌
" ▀            ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀        ▀▀  ▀▀▀▀▀▀▀▀▀▀▀ 

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.config/nvim/autoload/plugged')


    " Language support
    Plug 'sheerun/vim-polyglot'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

    " Status line TODO: use this or hand made one? 
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " FuzzyFinder
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'    " Fzf integration
    Plug 'airblade/vim-rooter' " Changes vim working directory to the project
    Plug 'romainl/vim-cool'    " When using find with / after moving disable highlight

    " User friendly
    Plug 'liuchengxu/vim-which-key' " Press the leader <SPACE> to show all the available commands TODO: Configure it
    Plug 'mhinz/vim-startify'       " Welcome page TODO: Still need to configure bookmarks on this

    " Visual Upgrades && Themes 
    Plug 'ryanoasis/vim-devicons'      " Icons
    Plug 'norcalli/nvim-colorizer.lua' " Confure for color codes to be displayed with real colors #412 #000 #fff
    "Plug 'chriskempson/base16-vim'     " All the possible themes, TODO: use it with set-theme code
    Plug 'morhetz/gruvbox'             " Gruvbox theme
    Plug 'ayu-theme/ayu-vim'
    Plug 'jdsimcoe/abstract.vim'
    Plug 'ajmwagar/vim-deus'
    Plug 'srcery-colors/srcery-vim'

    " Usability
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'AndrewRadev/switch.vim'         " TODO: configure this, dictionary of antonyms (e.g. True <-> False)
    Plug 'scrooloose/nerdcommenter'       " Commenting with leader key (e.g. <leader> c <space>)
    Plug 'liuchengxu/vista.vim'           " TODO: Configure this 
    Plug 'Yggdroot/indentLine'            " Add indent lines
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'tpope/vim-surround'             " Change surroudings of a word

    " Tmux and terminal integration
    Plug 'wincent/terminus'               " Increase mouse integration between Terminal, Tmux and Vim
    Plug 'terryma/vim-multiple-cursors'
    Plug 'christoomey/vim-tmux-navigator' " Use ctrl + hjkl to change pane
    Plug 'tmux-plugins/vim-tmux-focus-events'

    " Auto pair, Close and finish. Prefer vim-closer but conflicts with COC
    Plug 'jiangmiao/auto-pairs'
    " Plug 'rstacruz/vim-closer'

    " Snips 
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

    " Plug 'mattn/emmet-vim'

    " Git configuration
    Plug 'airblade/vim-gitgutter' " Add git diff on the left side
    Plug 'tpope/vim-fugitive'     " Git for vim

    " Markdown
    Plug 'plasticboy/vim-markdown'
    Plug 'godlygeek/tabular'

    Plug 'editorconfig/editorconfig-vim'
call plug#end()

" ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄         ▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄ 
"▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌
"▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀▀▀ 
"▐░▌          ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░▌          ▐░▌          
"▐░█▄▄▄▄▄▄▄▄▄ ▐░▌       ▐░▌▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄█░▌▐░▌          ▐░█▄▄▄▄▄▄▄▄▄ 
"▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░▌          ▐░░░░░░░░░░░▌
" ▀▀▀▀▀▀▀▀▀█░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░█▀▀▀▀█░█▀▀ ▐░▌          ▐░█▀▀▀▀▀▀▀▀▀ 
"          ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░▌     ▐░▌  ▐░▌          ▐░▌          
" ▄▄▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌▐░▌      ▐░▌ ▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄▄▄ 
"▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌
" ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀         ▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀ 

set encoding=UTF-8

source $HOME/.config/nvim/general/main.vim
source $HOME/.config/nvim/plug-config/main.vim
source $HOME/.config/nvim/themes/main.vim
source $HOME/.config/nvim/keys/main.vim

highlight clear SignColumn
set showtabline=1
set showmode

" TODO: look into this
" https://github.com/dbeniamine/cheat.sh-vim
" https://github.com/chubin/cheat.sh


" FONTS:
" - https://github.com/i-tu/Hasklig
" - https://github.com/tonsky/FiraCode (Current)
" - https://github.com/source-foundry/Hack

" Generate ASCII
" SOURCE: http://patorjk.com/software/taag/
" FONT: eletronic

" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiff<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

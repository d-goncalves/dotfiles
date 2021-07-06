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
    Plug 'prettier/vim-prettier', { 'do': 'yarn install' } " Code Format to .prettierrc

    " Telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'fannheyward/telescope-coc.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }


    " User friendly
    Plug 'liuchengxu/vim-which-key' " Using the leader key <space> show some keybinds
    Plug 'mhinz/vim-startify'       " Project start menu with cowsay

    " Visual Upgrades
    Plug 'ryanoasis/vim-devicons'                               " Icons
    Plug 'norcalli/nvim-colorizer.lua'                          " Display Color Codes text with color #412 #000 #fff
    Plug 'romainl/vim-cool'                                     " When using find with / after moving disable highlight
    Plug 'AndrewRadev/splitjoin.vim'                            " Add gJ and gS split or join multi line texts
    Plug 'vim-scripts/ShowTrailingWhitespace'                   " Show Trailing Whitespace
    Plug 'itchyny/vim-cursorword'                               " Highlight multiple instances of the same word when hovered
    Plug 'lukas-reineke/indent-blankline.nvim'                  " Show indention for blank lines

    " Tree sitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Improved syntax highlighting
    Plug 'romgrk/nvim-treesitter-context'

    " Dependecy
    Plug 'Olical/aniseed', { 'tag': 'v3.19.0' }
    Plug 'nvim-treesitter/nvim-tree-docs'

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

    Plug 'tomasiser/vim-code-dark'

    Plug 'vimwiki/vimwiki'
call plug#end()


lua << EOF
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
    }
  }
}
require('telescope').load_extension('coc')
require('telescope').load_extension('fzf')
EOF

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "typescript", "json", "c", "cpp", "cuda", "dockerfile", "latex", "lua", "php", "python", "vue", "yaml"},    -- one of "all", "language", or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { },  -- list of language that will be disabled
  },
  tree_docs = {
    enable = true,
    keymaps = {
        doc_node_at_cursor = "<leader>a"
        },
  },
}

require'treesitter-context.config'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
}
EOF


augroup UltestRunner
    au!
    au BufWritePost * UltestNearest
augroup END

let test#python#pytest#options = "--color=yes"
let test#javascript#jest#options = "--color=always"
let g:ultest_use_pty = 1

" Vim wiki
let g:vimwiki_list = [{'syntax': 'markdown', 'ext':'.md'}]

" Source everything
source $HOME/.config/nvim/plug-config/main.vim
source $HOME/.config/nvim/settings.vim
source $HOME/.config/nvim/keys/main.vim

set termguicolors
lua<<EOF
    require'colorizer'.setup() -- Colorize configuration
EOF

" Theme
set t_Co=256
set t_ut=
colorscheme codedark

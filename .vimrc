set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

"Vundle Plugins
call vundle#begin()
Plugin 'VundleVim/Vundle.vim' "Default plugin
Plugin 'sheerun/vim-polyglot' "Syntax highlight 
Plugin 'scrooloose/syntastic' "Help get errors
Plugin 'vim-airline/vim-airline'
Plugin 'SirVer/ultisnips'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdcommenter'
" Plugin 'Valloric/YouCompleteMe'
"://github.com/tpope?tab=repositories
call vundle#end()

" Detect filetype and syntax for certain file types
" syntax on
filetype plugin indent on

set number relativenumber "Show relative_numbers on the left of the text and the current number of the text"

nmap <F8> :TagbarToggle<CR>


" Change tab to 4 spaces
set tabstop=2
set shiftwidth=2
set expandtab


set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

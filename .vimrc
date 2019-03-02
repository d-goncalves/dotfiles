set rtp+=~/.vim/bundle/Vundle.vim

"Vundle Plugins
call vundle#begin()
Plugin 'VundleVim/Vundle.vim' "Default plugin
Plugin 'sheerun/vim-polyglot' "Syntax highlight 
call vundle#end()

" Detect filetype and syntax for certain file types
syntax on
filetype plugin indent on
filetype on

set nocompatible
set number relativenumber "Show relative_numbers on the left of the text and the current number of the text"

" Change tab to 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

" FileType specific commands

" FileType: Vimscript {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" }}}
" FileType: Lua {{{
augroup filetype_lua
    autocmd!
    autocmd FileType lua setlocal foldmethod=marker
augroup END
" }}}

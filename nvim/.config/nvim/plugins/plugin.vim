" General Plugin support

" Unit Test Configuration ---------------------- {{{

augroup UltestRunner
    au!
    au BufWritePost * UltestNearest
augroup END

let test#python#pytest#options = "--color=yes"
let test#javascript#jest#options = "--color=always"
let g:ultest_use_pty = 1

" }}}
" Vim wiki ---------------------- {{{

let g:vimwiki_list = [{'syntax': 'markdown', 'ext':'.md'}] " Vim wiki

" }}}
" Indent blankline ---------------------- {{{

let g:indent_blankline_char = '│' " Indent blank line confiugration

" }}}
" Startify bookmarks ---------------------- {{{

" TODO: Create OS specific path
let g:startify_bookmarks = [
        \ { 'b': '~/code/docker-beevo' },
        \ { 'd1': '~/code/docker-beevo/html/delta' },
        \ { 'en': '~/code/ma-engine' },
        \ { 'ma': '~/code/ma-apps' },
        \ { 'mf': '~/code/ma-frontend' },
        \ { 'term': '~/.config/alacritty/alacritty.yml' },
        \ { 'tmux': '~/.tmux.conf' },
        \ { 'vim': '~/.config/nvim/init.vim' },
        \ { 'zsh': '~/.zshrc' },
        \ ]

" }}}


iabbrev @@    you@example.com
" for me this is nor a normal remap still
inoremap <esc> <nop>

" inside next parentheses
onoremap in( :<c-u>normal! f(vi(<cr>
" inside last parentheses
onoremap il( :<c-u>normal! F)vi(<cr>

" inside next parentheses
onoremap in[ :<c-u>normal! f[vi[<cr>
" inside last parentheses
onoremap il[ :<c-u>normal! F]vi[<cr>

" inside next parentheses
onoremap in{ :<c-u>normal! f{vi}<cr>
" inside last parentheses
onoremap il{ :<c-u>normal! F}vi{<cr>

" NOTE: g_ same as my mapping for 0
" Vimscript file settings ---------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" TODO: Add a way to do this
" Command to add a semicolumn to the end of the line
"nnoremap <c-;> :execute "normal! mqA;\<esc>`q"
"inoremap <c-;> :execute "normal! mqA;\<esc>`q"

" Grep the under cursor with leader
nnoremap <leader>g :silent execute "grep! -r " . shellescape(expand("<cword>")) . " ."<cr>:copen<cr>


" set silent (no beep)
set vb t_vb=".

nmap <silent> gw    ma"_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<cr>`a
" was example random?

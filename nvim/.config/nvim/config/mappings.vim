inoremap jk <Esc>
nnoremap <C-c> <Esc>

" Remap VIM 0 to first non-blank character
map 0 ^

" Alternate way to save
nnoremap <C-s> :up<CR>
nnoremap <C-Q> :wq!<CR>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" add yank from previously yanked and not deleted
nmap ,p "0p
nmap ,P "0P

" Better window navigation
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" map ESC to exist terminal mode
tnoremap <Esc> <C-\><C-n>

function! s:ToggleBlame()
    if &l:filetype ==# 'fugitiveblame'
        close
    else
        Git blame
    endif
endfunction

nnoremap <leader>gb :call <SID>ToggleBlame()<CR>
" nnoremap <leader>gb :call <SID>Git blame<CR>
" nnoremap <leader>gc :call <SNR>GBrowse(expand('<cword>'))<CR>
" vnoremap <leader>gl :call GBrowse!<CR>

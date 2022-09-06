
inoremap jk <Esc>
nnoremap <C-c> <Esc>


nnoremap <Left>    :resize -2<CR>
nnoremap <Right>    :resize +2<CR>
nnoremap <Down>    :vertical resize -2<CR>
nnoremap <Up>    :vertical resize +2<CR>

" Remap VIM 0 to first non-blank character
map 0 ^

" Alternate way to save
nnoremap <C-s> :up<CR>
" Alternate way to quit
nnoremap <C-Q> :wq!<CR>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" add yank from previously yanked and not deleted
nmap ,p "0p
nmap ,P "0P

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" gw - change word under cursor with next
nnoremap <silent> gw    ma"_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<cr>`a
" gb - change word under cursor with next
nnoremap <silent> gb    ma"_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`a

" Command to add a semicolumn to the end of the line
nnoremap <silent> g;    maA;<esc>`a
nnoremap <silent> g,    maA,<esc>`a
nnoremap <silent> g.    maA.<esc>`a
nnoremap <silent> g:    maA:<esc>`a

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

nnoremap <leader>m :Vifm<cr>

" map ESC to exist terminal mode
tnoremap <Esc> <C-\><C-n>

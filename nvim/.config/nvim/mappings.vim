"Mappings

" Remove h/j/k/l
nnoremap <Left>  :echoe Move<CR>
nnoremap <Right> :echoe Move<CR>
nnoremap <Up>    :echoe Move<CR>
nnoremap <Down>  :echoe Move<CR>
inoremap <Left>  <ESC>:echoe Move<CR>
inoremap <Right> <ESC>:echoe Move<CR>
inoremap <Up>    <ESC>:echoe Move<CR>
inoremap <Down>  <ESC>:echoe Move<CR>

" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>

" Remap to jk to get escape
inoremap jk <Esc>
" Use control-c instead of escape
nnoremap <C-c> <Esc>

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

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



" Terminal Mode
" map ESC to exist terminal mode
tnoremap <Esc> <C-\><C-n>

" Fugitive Conflict Resolution
nnoremap <leader>Gd :Gvdiff<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>
nnoremap <leader>Gc <cmd>lua require('telescope.builtin').git_bcommits()<cr>

" TODO: Still need to get a strict search ( ex: grep abc must only match exatcly abc )
map <C-f> <cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fs <cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').git_bcommits()<cr>
nnoremap <leader>ft :TodoTelescope<cr>
nnoremap <leader>C <cmd>lua require('telescope.builtin').colorscheme()<cr>

" COC configuration

" Navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <leader>ldN <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>ldn <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>lrn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>lf  <Plug>(Prettier)
nmap <leader>lf  <Plug>(Prettier)

" Applying codeAction to the selected region.
" Example: `<leader>laap` for current paragraph
xmap <leader>la  <Plug>(coc-codeaction-selected)
nmap <leader>la  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>lac  <Plug>(coc-codeaction)

" Apply AutoFix to problem on the current line.
nmap <leader>lqf  <Plug>(coc-fix-current)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <leader>ls <Plug>(coc-range-select)
xmap <silent> <leader>ls <Plug>(coc-range-select)

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <leader>ld  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>le  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <leader>lc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>lo  :<C-u>CocList outline<cr>
" Do default action for next item.
nnoremap <silent><nowait> <leader>lj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <leader>lk  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <leader>lp  :<C-u>CocListResume<CR>
nnoremap <space>e :CocCommand explorer<CR>

" Test mapping
nnoremap <leader> tn <Plug>(ultest-next-fail)

" Get Telescope TODO list
nnoremap <leader>t :TodoQuickFix<cr>

nnoremap <leader>m :Vifm<cr>

" NOTE: g_ same as my mapping for 0
" nnoremap _ g_

" Map gw to change current word with next
nnoremap <silent> gw    ma"_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<cr>`a

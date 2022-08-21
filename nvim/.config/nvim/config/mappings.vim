" Mappings

" Editor: Remove bad habits {{{

" Remove all arrow functionality
nnoremap <Left>  :echoe Move<CR>
nnoremap <Right> :echoe Move<CR>
nnoremap <Up>    :echoe Move<CR>
nnoremap <Down>  :echoe Move<CR>
inoremap <Left>  <ESC>:echoe Move<CR>
inoremap <Right> <ESC>:echoe Move<CR>
inoremap <Up>    <ESC>:echoe Move<CR>
inoremap <Down>  <ESC>:echoe Move<CR>

" Remap to jk to get escape
inoremap jk <Esc>
" Use control-c instead of escape
nnoremap <C-c> <Esc>

" Remove ESC as a mapping, not usable
inoremap <esc> <nop>
" }}}
" Editor: Resize windows {{{

nnoremap <M-J>    :resize -2<CR>
nnoremap <M-K>    :resize +2<CR>
nnoremap <M-H>    :vertical resize -2<CR>
nnoremap <M-L>    :vertical resize +2<CR>

" }}}
" Editor: Navigation {{{

" Remap VIM 0 to first non-blank character
map 0 ^
" Map _ to last non-blank character
nnoremap _ g_

" }}}
" Editor: Move line {{{

nnoremap <Up> :m .+1<CR>==
nnoremap <Down> :m .-2<CR>==
inoremap <Up> <Esc>:m .+1<CR>==gi
inoremap <Down> <Esc>:m .-2<CR>==gi
vnoremap <Up> :m '>+1<CR>gv=gv
vnoremap <Down> :m '<-2<CR>gv=gv

" }}}
" Editor: Save and Quit {{{

" Alternate way to save
nnoremap <C-s> :up<CR>
" Alternate way to quit
nnoremap <C-Q> :wq!<CR>

" }}}
" Editor: Tabbing {{{

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" }}}
" Editor: Yank {{{

" add yank from previously yanked and not deleted
nmap ,p "0p
nmap ,P "0P

" }}}
" Editor: Window Navigation {{{

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" }}}
" Editor: Move words {{{

" gw - change word under cursor with next
nnoremap <silent> gw    ma"_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<cr>`a
" gb - change word under cursor with next
nnoremap <silent> gb    ma"_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`a

" }}}
" Editor: Append semicolumn {{{

" Command to add a semicolumn to the end of the line
nnoremap <silent> g;    maA;<esc>`a
nnoremap <silent> g,    maA,<esc>`a
nnoremap <silent> g.    maA.<esc>`a
nnoremap <silent> g:    maA:<esc>`a

" }}}
" Editor/Plugin: Focus mode {{{

nnoremap <leader>mf :Goyo<cr>:LimeLight<cr>

" }}}

" Plugin: LvimHelper {{{

nnoremap <leader>H :LvimHelper<cr>

" }}}
" Plugin: Todo-comments {{{

" Get Telescope TODO list
nnoremap <leader>t :TodoQuickFix<cr>

" }}}
" Plugin: EasyAlign {{{

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" }}}
" Plugin: Fugitive {{{

" Fugitive Conflict Resolution
nnoremap <leader>Gd :Gvdiff<CR>
nnoremap <leader>Gh :0Gclog<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

" }}}
" Plugin: Vifm {{{
nnoremap <leader>m :Vifm<cr>
" }}}
" Plugin: WhichKey {{{

" Map leader to which_key
nnoremap <silent> <leader> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" }}}
" Plugin: Telescope {{{
"
" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fs <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>C <cmd>lua require('telescope.builtin').colorscheme()<cr>

" }}}

autocmd filetype * nnoremap <F8> :w <BAR> :Shell cd "$(VIM_ROOT)"; ./run.sh <CR>

" Compilation: Cpp {{{

" " For more Complex compilation processes it might be useful to build something
" " more robust -> https://github.com/skywind3000/asyncrun.vim

" autocmd filetype cpp nnoremap <F8> :w <BAR> :Shell g++ --std=c++20 %; if [ -f a.out ]; then time ./a.out; rm a.out; fi <CR>

" command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
" function! s:RunShellCommand(cmdline) abort
"     exe 'split | terminal '. a:cmdline
" endfunction
" " }}}
" " Compilation: Bash {{{

" autocmd filetype sh nnoremap <F8> :w <BAR> :Shell ./% <CR>

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline) abort
    exe 'split | terminal '. a:cmdline
endfunction
" }}}

" Terminal {{{

" map ESC to exist terminal mode
tnoremap <Esc> <C-\><C-n>

" }}}

" Abbreviation {{{

iabbrev @@    you@example.com

" }}}

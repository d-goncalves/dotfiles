" WhichKey

" Map leader to which_key
nnoremap <silent> <leader> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

let g:which_key_map =  {}            " Initialize
let g:which_key_sep = '→'            " Define a separator
let g:which_key_use_floating_win = 0 " Disable floating win

" Colorscheme match
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=1 noshowmode ruler

let g:which_key_map.g = { 'name' : '+GoTo' }
let g:which_key_map.G = { 'name' : '+Git' }
let g:which_key_map.h = { 'name' : '+GitGutter' }
let g:which_key_map.l = { 'name' : '+Language' }
let g:which_key_map.c = { 'name' : 'Comment' }
let g:which_key_map.e = 'Explorer'
let g:which_key_map.C = 'Themes'

let g:which_key_map.f = {
      \ 'name' : '+Find' ,
      \ "f": [ '<cmd>Telescope find_files<CR>', 'FZF' ],
      \ "g": [ '<cmd>Telescope live_grep<CR>', 'Git grep'],
      \ "r": [ '<cmd>Telescope buffers<CR>', 'Ripgrep'],
      \ "s": [ '<cmd>Telescope grep_string<CR>', 'Ripgrep'],
      \ "h": [ '<cmd>Telescope git_bcommits<CR>', 'Commit History'],
      \ }

" Register which key map
autocmd VimEnter * call which_key#register('<Space>', "g:which_key_map")

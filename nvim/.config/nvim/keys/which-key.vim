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

let g:which_key_map.g = { 'name' : '+LanguageGoTo' }
let g:which_key_map.G = { 'name' : '+Git' }
let g:which_key_map.h = { 'name' : '+GitGutter' }
let g:which_key_map.l = { 'name' : '+Language' }
let g:which_key_map.c = { 'name' : 'Comment' }
let g:which_key_map.w = { 'name' : '+VimWiki' }
let g:which_key_map.d = 'Generate Doc'
let g:which_key_map.e = 'Explorer'
let g:which_key_map.C = 'Themes'

let g:which_key_map.f = {
      \ 'name' : '+Find' ,
      \ "f": [ ':Telescope find_files', 'Files' ],
      \ "g": [ ':Telescope live_grep', 'Git'],
      \ "r": [ ':Telescope grep_string', 'Grep'],
      \ "s": [ ':Telescope grep_string', 'TODO: Strict'],
      \ "b": [ ':Telescope buffers ', 'Buffers'],
      \ "h": [ ':Telescope git_bcommits', 'Commit History'],
      \ }

" Register which key map
autocmd VimEnter * call which_key#register('<Space>', "g:which_key_map")

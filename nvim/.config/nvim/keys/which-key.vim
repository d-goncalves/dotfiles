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

"let g:which_key_map['f'] = '+Find'
let g:which_key_map['e'] = [ ':CocCommand explorer' , 'Explorer' ]
let g:which_key_map['c'] = [ '<Plug>NERDCommenterToggle'  , 'Comment Toggle' ]
let g:which_key_map.f = {
      \ 'name' : '+Find' ,
      \ "f": [ 'Files'  , 'FZF' ],
      \ "g": [ 'GGrep', 'Git grep'],
      \ "r": [ 'Rg', 'Ripgrep'],
      \ "a": [ 'Ag', 'Ack grep'],
      \ "s": [ 'RG', 'Strict Ripgrep'],
      \ "b": [ 'Buffers', 'Buffers'],
      \ }

let g:which_key_map.g = {
      \ 'name' : '+GoTo' ,
      \ }

let g:which_key_map.G = {
      \ 'name' : '+Git' ,
      \ }

let g:which_key_map.h = {
      \ 'name' : '+GitGutter' ,
      \ }

let g:which_key_map.l = {
      \ 'name' : '+Language' ,
      \ }

" Register which key map
autocmd VimEnter * call which_key#register('<Space>', "g:which_key_map")

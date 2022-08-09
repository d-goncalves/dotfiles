" General Vimscript Plugin support

" Plugin: Vim wiki {{{

let g:vimwiki_list = [{'syntax': 'markdown', 'ext':'.md'}] " Vim wiki

" }}}
" Plugin: EditorConfig {{{

" Exclude Fugitive due to conflicts
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" }}}
" Plugin: Startify  {{{

if has("macunix")
    let g:startify_bookmarks = [
                \ { 'term': '~/.config/alacritty/alacritty.yml' },
                \ { 'tmux': '~/.tmux.conf' },
                \ { 'vim': '~/.config/nvim/init.vim' },
                \ { 'zsh': '~/.zshrc' },
                \ ]
elseif has("win32")
    "all Windows, ie win32,win64
elseif has("win32unix")
    "Cygwin
elseif has("unix")
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
    "Linux
end

" }}}
" Plugin: Crease {{{

set fillchars=fold:━
let g:crease_foldtext = { 'default': '%f%f┫ %t ┣%=┫ %l lines ┣%f%f' }

" }}}
" " Plugin: WhichKey {{{
" " WhichKey

" let g:which_key_map =  {}            " Initialize
" let g:which_key_sep = '→'            " Define a separator
" let g:which_key_use_floating_win = 0 " Disable floating win

" " Colorscheme match
" highlight default link WhichKey          Operator
" highlight default link WhichKeySeperator DiffAdded
" highlight default link WhichKeyGroup     Identifier
" highlight default link WhichKeyDesc      Function

" " Hide status line
" autocmd! FileType which_key
" autocmd  FileType which_key set laststatus=0 noshowmode noruler
"   \| autocmd BufLeave <buffer> set laststatus=1 noshowmode ruler

" let g:which_key_map.g = { 'name' : '+LanguageGoTo' }
" let g:which_key_map.G = { 'name' : '+Git' }
" let g:which_key_map.h = { 'name' : '+GitGutter' }
" let g:which_key_map.l = { 'name' : '+Language' }
" let g:which_key_map.c = { 'name' : 'Comment' }
" let g:which_key_map.w = { 'name' : '+VimWiki' }
" let g:which_key_map.d = 'Generate Doc'
" let g:which_key_map.e = 'Explorer'
" let g:which_key_map.C = 'Themes'

" let g:which_key_map.f = {
"       \ 'name' : '+Find' ,
"       \ "f": [ ':Files', 'Files' ],
"       \ "g": [ ':GGrep', 'Git'],
"       \ "r": [ ':Rg', 'Rg'],
"       \ "a": [ ':Ag', 'Ag'],
"       \ "s": [ ':RG', 'Strict Grep'],
"       \ "b": [ ':Buffers', 'Buffers'],
"       \ }

" let g:which_key_map.r = {
"       \ 'name' : '+Refactor' ,
"       \ "e": [ '', 'Function' ],
"       \ "f": [ '', 'Funtion to file'],
"       \ "t": [ ':lua M.refactors()', 'List'],
"       \ }

" " Register which key map
" autocmd VimEnter * call which_key#register('<Space>', "g:which_key_map")

" " }}}

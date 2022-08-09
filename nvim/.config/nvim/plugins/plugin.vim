" General Vimscript Plugin support

" Plugin: Vim wiki {{{

let g:vimwiki_list = [{'syntax': 'markdown', 'ext':'.md'}] " Vim wiki

" }}}
" Plugin: EditorConfig {{{

" Exclude Fugitive due to conflicts
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" }}}
" Plugin: Switch {{{

" Default mapping is gs
let g:switch_custom_definitions =
    \ [
    \   ['foo', 'bar', 'baz']
    \ ]

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
" " Plugin: Coc {{{
" " COC configuration

" " General configuration to install
" let g:coc_global_extensions = [
"                                 \ 'coc-json',
"                                 \ 'coc-tsserver',
"                                 \ 'coc-html',
"                                 \ 'coc-css',
"                                 \ 'coc-yaml',
"                                 \ 'coc-docker',
"                                 \ 'coc-sql',
"                                 \ 'coc-python',
"                                 \ 'coc-clangd',
"                                 \ 'coc-phpls',
"                                 \ 'coc-sh',
"                                 \ 'coc-explorer',
"                                 \ 'coc-snippets',
"                                 \ 'coc-eslint',
"                                 \ 'coc-yank'
"                                 \ ]


" " Explorer configuration
" let g:coc_explorer_global_presets = {
"                                 \   '.vim': {
"                                 \     'root-uri': '~/.vim',
"                                 \   },
"                                 \   'tab': {
"                                 \     'position': 'tab',
"                                 \     'quit-on-open': v:true,
"                                 \   },
"                                 \   'floating': {
"                                 \     'position': 'floating',
"                                 \     'open-action-strategy': 'sourceWindow',
"                                 \   },
"                                 \   'floatingTop': {
"                                 \     'position': 'floating',
"                                 \     'floating-position': 'center-top',
"                                 \     'open-action-strategy': 'sourceWindow',
"                                 \   },
"                                 \   'floatingLeftside': {
"                                 \     'position': 'floating',
"                                 \     'floating-position': 'left-center',
"                                 \     'floating-width': 50,
"                                 \     'open-action-strategy': 'sourceWindow',
"                                 \   },
"                                 \   'floatingRightside': {
"                                 \     'position': 'floating',
"                                 \     'floating-position': 'right-center',
"                                 \     'floating-width': 50,
"                                 \     'open-action-strategy': 'sourceWindow',
"                                 \   },
"                                 \   'simplify': {
"                                 \     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
"                                 \   }
"                                 \ }

" " Configuration
" let g:UltiSnipsExpandTrigger = "<nop>"
" " Make <CR> auto-select the first completion item and notify coc.nvim
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm(): "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" " Show documentation with K
" nnoremap <silent> K :call <SID>show_documentation()<CR>

" " TODO: Must ensure that tab completion works like DoGe ( Tabs work properly )
" " Use tab for trigger completion with characters ahead and navigate.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


" " New commands
" command! -nargs=0 Format :call CocAction('format') " Command to format current buffer.
" command! -nargs=? Fold :call     CocAction('fold', <f-args>) " Command to fold current buffer.
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport') " Command for organize imports of the current buffer.


" " Autocommand and auGroup
" autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
" autocmd CursorHold * silent call CocActionAsync('highlight') " Highlight the symbol and its references when holding the cursor.

" augroup mygroup
"   autocmd!
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected') " Setup formatexpr specified filetype(s).
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp') " Update signature help on jump placeholder.
" augroup end


" " FUNCTIONS

" " Check backspaces
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" " Show documentation
" function! s:show_documentation()
"     if (index(['vim','help'], &filetype) >= 0)
"         execute 'h '.expand('<cword>')
"     elseif (coc#rpc#ready())
"         call CocActionAsync('doHover')
"     else
"         execute '!' . &keywordprg . " " . expand('<cword>')
"     endif
" endfunction
" " }}}

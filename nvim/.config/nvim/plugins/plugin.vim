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
" Plugin: Ultest {{{

augroup UltestRunner
    au!
    au BufWritePost * UltestNearest
augroup END

let test#python#pytest#options = "--color=yes"
let test#javascript#jest#options = "--color=always"
let g:ultest_use_pty = 1
let g:ultest_running_sign =	"⏯"

" }}}
" Plugin: WhichKey {{{
" WhichKey

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
      \ "f": [ ':Files', 'Files' ],
      \ "g": [ ':GGrep', 'Git'],
      \ "r": [ ':Rg', 'Rg'],
      \ "a": [ ':Ag', 'Ag'],
      \ "s": [ ':RG', 'Strict Grep'],
      \ "b": [ ':Buffers', 'Buffers'],
      \ }

let g:which_key_map.r = {
      \ 'name' : '+Refactor' ,
      \ "e": [ '', 'Function' ],
      \ "f": [ '', 'Funtion to file'],
      \ "t": [ ':lua M.refactors()', 'List'],
      \ }

" Register which key map
autocmd VimEnter * call which_key#register('<Space>', "g:which_key_map")

" }}}
" Plugin: Coc {{{
" COC configuration

" General configuration to install
let g:coc_global_extensions = [
                                \ 'coc-json',
                                \ 'coc-tsserver',
                                \ 'coc-html',
                                \ 'coc-css',
                                \ 'coc-yaml',
                                \ 'coc-docker',
                                \ 'coc-sql',
                                \ 'coc-python',
                                \ 'coc-clangd',
                                \ 'coc-phpls',
                                \ 'coc-sh',
                                \ 'coc-explorer',
                                \ 'coc-snippets',
                                \ 'coc-eslint',
                                \ 'coc-yank'
                                \ ]


" Explorer configuration
let g:coc_explorer_global_presets = {
                                \   '.vim': {
                                \     'root-uri': '~/.vim',
                                \   },
                                \   'tab': {
                                \     'position': 'tab',
                                \     'quit-on-open': v:true,
                                \   },
                                \   'floating': {
                                \     'position': 'floating',
                                \     'open-action-strategy': 'sourceWindow',
                                \   },
                                \   'floatingTop': {
                                \     'position': 'floating',
                                \     'floating-position': 'center-top',
                                \     'open-action-strategy': 'sourceWindow',
                                \   },
                                \   'floatingLeftside': {
                                \     'position': 'floating',
                                \     'floating-position': 'left-center',
                                \     'floating-width': 50,
                                \     'open-action-strategy': 'sourceWindow',
                                \   },
                                \   'floatingRightside': {
                                \     'position': 'floating',
                                \     'floating-position': 'right-center',
                                \     'floating-width': 50,
                                \     'open-action-strategy': 'sourceWindow',
                                \   },
                                \   'simplify': {
                                \     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
                                \   }
                                \ }

" Configuration
let g:UltiSnipsExpandTrigger = "<nop>"
" Make <CR> auto-select the first completion item and notify coc.nvim
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm(): "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Show documentation with K
nnoremap <silent> K :call <SID>show_documentation()<CR>

" TODO: Must ensure that tab completion works like DoGe ( Tabs work properly )
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


" New commands
command! -nargs=0 Format :call CocAction('format') " Command to format current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>) " Command to fold current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport') " Command for organize imports of the current buffer.


" Autocommand and auGroup
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
autocmd CursorHold * silent call CocActionAsync('highlight') " Highlight the symbol and its references when holding the cursor.

augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected') " Setup formatexpr specified filetype(s).
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp') " Update signature help on jump placeholder.
augroup end


" FUNCTIONS

" Check backspaces
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Show documentation
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction
" }}}
" Plugin: FZF {{{
" FZF configuration

let g:fzf_history_dir = '~/.local/share/fzf-history' " Enable per-command history.
let g:fzf_tags_command = 'ctags -R' " Tags command (Not recommended)

" Key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-h': 'split',
  \ 'ctrl-v': 'vsplit' }

" Window configuration
let g:fzf_layout = {
            \ 'up':'~90%',
            \ 'window': {
                      \ 'width': 0.8,
                      \ 'height': 0.8,
                      \ 'yoffset':0.5,
                      \ 'xoffset': 0.5,
                      \ 'highlight': 'Todo',
                      \ 'border': 'sharp'
            \}
\ }

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline '
let $FZF_DEFAULT_COMMAND="rg --files --hidden"

"Get File
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" Get text in files with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)


" Colorscheme - set fzf colors to match Colorscheme
let g:fzf_colors = {
    \ 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment']
    \ }

"
" FUNCTION CONFIGURATION
"

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

" Files + devicons + floating fzf
function! FzfFilePreview()
  let l:fzf_files_options = '--preview "bat --theme="gruvbox" --style=numbers,changes --color always {3..-1} | head -200" --expect=ctrl-v,ctrl-x'
  " --theme="OneHalfDark"
  let s:files_status = {}

  function! s:cacheGitStatus()
    let l:gitcmd = 'git -c color.status=false -C ' . $PWD . ' status -s'
    let l:statusesStr = system(l:gitcmd)
    let l:statusesSplit = split(l:statusesStr, '\n')
    for l:statusLine in l:statusesSplit
      let l:fileStatus = split(l:statusLine, ' ')[0]
      let l:fileName = split(l:statusLine, ' ')[1]
      let s:files_status[l:fileName] = l:fileStatus
    endfor
  endfunction

  function! s:files()
    call s:cacheGitStatus()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_indicators(l:files)
  endfunction

  function! s:prepend_indicators(candidates)
    return s:prepend_git_status(s:prepend_icon(a:candidates))
  endfunction

  function! s:prepend_git_status(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:status = ''
      let l:icon = split(l:candidate, ' ')[0]
      let l:filePathWithIcon = split(l:candidate, ' ')[1]

      let l:pos = strridx(l:filePathWithIcon, ' ')
      let l:file_path = l:filePathWithIcon[pos+1:-1]
      if has_key(s:files_status, l:file_path)
        let l:status = s:files_status[l:file_path]
        call add(l:result, printf('%s %s %s', l:status, l:icon, l:file_path))
      else
        " printf statement contains a load-bearing unicode space
        " the file path is extracted from the list item using {3..-1},
        " this breaks if there is a different number of spaces, which
        " means if we add a space in the following printf it breaks.
        " using a unicode space preserves the spacing in the fzf list
        " without breaking the {3..-1} index
        call add(l:result, printf('%s %s %s', ' ', l:icon, l:file_path))
      endif
    endfor

    return l:result
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s %s', l:icon, l:candidate))
    endfor

    return l:result
  endfunction

  function! s:edit_file(lines)
    if len(a:lines) < 2 | return | endif

    let l:cmd = get({'ctrl-x': 'split',
                 \ 'ctrl-v': 'vertical split',
                 \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')

    for l:item in a:lines[1:]
      let l:pos = strridx(l:item, ' ')
      let l:file_path = l:item[pos+1:-1]
      execute 'silent '. l:cmd . ' ' . l:file_path
    endfor
  endfunction

  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink*':   function('s:edit_file'),
        \ 'options': '-m --preview-window=right:70%:noborder --prompt Files\> ' . l:fzf_files_options,
        \ 'down':    '40%',
        \ 'window': 'call FloatingFZF()'})

endfunction

function! FloatingFZF()
    let width = float2nr(&columns * 0.85)
    let height = float2nr(&lines * 0.70)
    let opts = { 'relative': 'editor',
                \ 'row': (&lines - height) / 2,
                \ 'col': (&columns - width) / 2,
                \ 'width': width,
                \ 'height': height,
                \ 'style': 'minimal'}

    let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
endfunction
" }}}

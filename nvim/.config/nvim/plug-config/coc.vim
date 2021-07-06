" COC configuration

" General configuration to install
let g:coc_global_extensions = [
                                \ 'coc-json',
                                \ 'coc-tsserver',
                                \ 'coc-html',
                                \ 'coc-css',
                                \ 'coc-yaml',
                                \ 'coc-docker',
                                \ 'coc-git',
                                \ 'coc-sql',
                                \ 'coc-python',
                                \ 'coc-clangd',
                                \ 'coc-phpls',
                                \ 'coc-sh',
                                \ 'coc-explorer',
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

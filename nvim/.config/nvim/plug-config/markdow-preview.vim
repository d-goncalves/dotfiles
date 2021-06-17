let g:mkdp_auto_start = 1             " start window after entering the markdown buffer
let g:mkdp_auto_close = 1             " will auto close current preview window when change
let g:mkdp_refresh_slow = 0           " will refresh markdown when save the buffer or
let g:mkdp_command_for_global = 0     " set to 1, the MarkdownPreview command can be use for all files
let g:mkdp_browser = ''               " specify browser to open preview page
let g:mkdp_echo_preview_url = 0       " echo preview page url in command line when open preview page
let g:mkdp_markdown_css = ''          " use a custom markdown style must be absolute path
let g:mkdp_highlight_css = ''         " use a custom highlight style must absolute path
let g:mkdp_port = ''                  " use a custom port to start server or random for empty
let g:mkdp_page_title = '「${name}」' " preview page title , ${name} will be replace with the file name
let g:mkdp_filetypes = ['markdown']   " these filetypes will have MarkdownPreview... commands

" options for markdown render
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }


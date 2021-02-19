" Set global makrs
function! SetGMark(mark, filename, line_nr)
    let l:mybuf = bufnr(a:filename, 1)
    call setpos("'".a:mark, [l:mybuf, a:line_nr, 1, 0])
endf

call SetGMark('V', '~/.config/nvim/init.vim', 1)
call SetGMark('M', '~/Code/ma-apps/package.json', 1)
call SetGMark('B', '~/Code/docker-beevo/html', 1)

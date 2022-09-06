local opts = { noremap = true, silent = true }

vim.keymap.set("i", "jk", "<Esc>", opts)
vim.keymap.set("n", "<C-c>", "<Esc>", opts)
vim.keymap.set("i", "<C-c>", "<Esc>", opts)

vim.keymap.set("n", "<Left>", "<cmd>:resize -2<CR>", opts)
vim.keymap.set("n", "<Right>", "<cmd>:resize +2<CR>", opts)
vim.keymap.set("n", "<Down>", "<cmd>vertical resize -2<CR>", opts)
vim.keymap.set("n", "<Up>", "<cmd>vertical resize +2<CR>", opts)

vim.keymap.set("n", "<C-s>", "<cmd>:up<CR>", opts)
vim.keymap.set("n", "<C-q>", "<cmd>:wq!<CR>", opts)
vim.keymap.set("n", "<C-Q>", "<cmd>:q!<CR>", opts)

-- " Remap VIM 0 to first non-blank character
-- map 0 ^

-- " Better tabbing
-- vnoremap < <gv
-- vnoremap > >gv

-- " add yank from previously yanked and not deleted
-- nmap ,p "0p
-- nmap ,P "0P

-- " Better window navigation
-- nnoremap <C-h> <C-w>h
-- nnoremap <C-j> <C-w>j
-- nnoremap <C-k> <C-w>k
-- nnoremap <C-l> <C-w>l

-- " gw - change word under cursor with next
-- nnoremap <silent> gw    ma"_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<cr>`a
-- " gb - change word under cursor with next
-- nnoremap <silent> gb    ma"_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`a

-- " Command to add a semicolumn to the end of the line
-- nnoremap <silent> g;    maA;<esc>`a
-- nnoremap <silent> g,    maA,<esc>`a
-- nnoremap <silent> g.    maA.<esc>`a
-- nnoremap <silent> g:    maA:<esc>`a

-- xmap ga <Plug>(EasyAlign)
-- nmap ga <Plug>(EasyAlign)

-- nnoremap <leader>m :Vifm<cr>

-- " map ESC to exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)

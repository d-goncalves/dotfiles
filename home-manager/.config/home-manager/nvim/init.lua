vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"folke/which-key.nvim",
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	"folke/neodev.nvim",
	"nvim-lua/popup.nvim",
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"romgrk/nvim-treesitter-context",
	"p00f/nvim-ts-rainbow",


	"neovim/nvim-lspconfig",
    { 'dundalek/lazy-lsp.nvim', requires = { 'neovim/nvim-lspconfig' } },
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-calc",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-path",
	"onsails/lspkind.nvim",

	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"lewis6991/gitsigns.nvim",

	"terryma/vim-expand-region",
	"tpope/vim-surround",
	"tpope/vim-commentary",
	"tpope/vim-repeat",
	"coderifous/textobj-word-column.vim",
	"andymass/vim-matchup",
	"wellle/targets.vim",
	"AndrewRadev/splitjoin.vim",
	"junegunn/vim-easy-align",
	"justinmk/vim-gtfo",
	"romainl/vim-cool",
	"markonm/traces.vim",
	"windwp/nvim-autopairs",
	"direnv/direnv.vim",
	"kyazdani42/nvim-web-devicons",
	"NvChad/nvim-colorizer.lua",
	"johnfrankmorgan/whitespace.nvim",
	"itchyny/vim-cursorword",
	"lukas-reineke/indent-blankline.nvim",
	"christoomey/vim-tmux-navigator",
	"folke/which-key.nvim",
	"gruvbox-community/gruvbox",
	"Everblush/nvim",
	-- "williamboman/mason.nvim",
})

-- require("mason").setup()

vim.cmd([[

set mouse=a                  " Enable your mouse
set splitbelow
set splitright
set smartindent              " Makes indenting smart
set autoindent               " Good auto indent
set timeoutlen=500           " By default timeoutlen is 1000 ms
set formatoptions-=cro       " Stop newline continution of comments
set clipboard=unnamedplus    " Copy paste between vim and everything else
set shortmess+=c             " Remove default auto complete prompt
cmap w!! w !sudo tee %

" Configure backspace so it acts as it should act
set whichwrap+=h,l " Allow h,l to move to the next line

syntax enable              " Enables syntax highlighting

set ignorecase
set smartcase

set tabstop=4              " Insert 2 spaces for a tab
set shiftwidth=4           " Change the number of space characters inserted for indentation
set smarttab               " Makes tabbing smarter will realize you have 2 vs 4
set expandtab              " Converts tabs to spaces
set softtabstop=0

set noswapfile             " No swapfile
set nobackup
set nowritebackup
set undofile

set number relativenumber  " Line numbers
set scrolloff=4            " Always leave 4 lines when moving up or down

set showtabline=0          " Disable the top tab line
set laststatus=0           " Never display the status line
set pumheight=10           " Makes popup menu smaller
" set colorcolumn=120

set conceallevel=0         " So that I can see `` in markdown files
set cursorline             " Enable highlighting of the current line

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=20

" Mappings

inoremap jk <Esc>
nnoremap <C-c> <Esc>

" Remap VIM 0 to first non-blank character
map 0 ^

" Alternate way to save
nnoremap <C-s> :up<CR>
nnoremap <C-Q> :wq!<CR>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

function! ToggleBlame()
    if &l:filetype ==# 'fugitiveblame'
        close
    else
        Git blame
    endif
endfunction

" Set filetype for yaml.j2 files
au BufRead,BufNewFile *.yml.j2 set ft=yaml.jinja2
au BufRead,BufNewFile *.timer.j2 set ft=systemd.jinja2
au BufRead,BufNewFile *.service.j2 set ft=systemd.jinja2
au BufRead,BufNewFile *.timer set ft=systemd
au BufRead,BufNewFile *.service set ft=systemd
au BufRead,BufNewFile *.json.j2 set ft=json.jinja2

colorscheme everblush

]])

function cmd()
	local cmp = require("cmp")
	local lspkind = require("lspkind")

	local has_words_before = function()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	cmp.setup({
		enabled = function()
			-- disable autocompletion in prompt (wasn't playing good with telescope)
			buftype = vim.api.nvim_buf_get_option(0, "buftype")
			if buftype == "prompt" then
				return false
			end
			local context = require("cmp.config.context")
			-- disable autocompletion in comments
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
		end,
		view = { entries = { name = "custom", selection_order = "near_cursor" } },
		-- Window Format
		-- Not file format on save!
		formatting = { format = lspkind.cmp_format({ maxwidth = 50 }) },
		mapping = cmp.mapping.preset.insert({
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end, { "i", "s" }),
		}),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "calc" },
			{ name = "path" },
			{ name = "nvim_lua" },
			{ name = "nvim_lsp_signature_help" },
		}, { { name = "buffer" } }),
	})
end

function gitsigns()
	require("gitsigns").setup({ current_line_blame = true })

	local whichkey = require("which-key")
	local keymap_g = {
		g = {
			name = "Git",
			b = { "<cmd>call ToggleBlame()<CR>", "Blame" },
			d = { "<cmd>Gitsigns toggle_deleted<cr>", "Deleted" },
			h = { "<cmd>0Gclog<cr>", "History" },
			c = { "<cmd>.GBrowse<CR>", "Open Github" },
		},
	}
	whichkey.register(keymap_g, { prefix = "<leader>" })
end

function treesitter()
	require("nvim-treesitter.configs").setup({
		rainbow = { enable = true, extended_mode = true, max_file_lines = nil },
		auto_install = true,
		highlight = { enable = true },
		matchup = { enable = true },
	})
end

function telescope()
	require("telescope").load_extension("fzf")
	require("telescope").setup()

	local keymap = {
		f = {
			name = "Find",
			f = { "<cmd>Telescope git_files theme=ivy<cr>", "Find" },
			F = { "<cmd>Telescope find_files hidden=true theme=ivy<cr>", "FindAll" },
			b = { "<cmd>Telescope buffers theme=ivy<cr>", "Buffer" },
			t = { "<cmd>Telescope help_tags theme=ivy<cr>", "Tags" },
			s = { "<cmd>Telescope live_grep theme=ivy<cr>", "Grep" },
			g = { "<cmd>Telescope grep_string theme=ivy<cr>", "Grep" },
			C = { "<cmd>Telescope colorscheme theme=ivy<cr>", "Colorscheme" },
			c = { "<cmd>Telescope neoclip theme=ivy<cr>", "ClipBoard" },
			p = { "<cmd>Telescope projects theme=ivy<cr>", "Projects" },
			h = { "<cmd>Telescope oldfiles theme=ivy<cr>", "Previous Files" },
		},
	}

	local whichkey = require("which-key")
	whichkey.register(keymap, {
		mode = "n",
		prefix = "<leader>",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = false,
	})
end

local function cursorHoldDiagnostic()
	-- CursorHold
	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
		callback = function()
			local opts = {
				focusable = false,
				close_events = {
					"BufLeave",
					"CursorMoved",
					"InsertEnter",
					"FocusLost",
				},
				border = "rounded",
				source = "always",
				prefix = " ",
				scope = "cursor",
			}
			vim.diagnostic.open_float(nil, opts)
		end,
	})
end

local function changeLspIcons()
	local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end
end

local function keymappings(client, bufnr)
	local opts = { noremap = true, silent = true }

	-- Key mappings
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

	-- Whichkey
	local keymap_l = {
		l = {
			name = "Language",
			r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
			a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
			d = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Line Diagnostics" },
			i = { "<cmd>LspInfo<CR>", "Lsp Info" },
			f = { "<cmd>lua vim.lsp.buf.format({bufnr = bufnr})<CR>", "Format Document" },
		},
	}

	local keymap_g = {
		name = "LSP Goto",
		d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
		r = { "<Cmd>lua vim.lsp.buf.references()<CR>", "References" },
		D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
		s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
		I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation" },
		t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" },
	}
	local whichkey = require("which-key")
	whichkey.register(keymap_l, { buffer = bufnr, prefix = "<leader>" })
	whichkey.register(keymap_g, { buffer = bufnr, prefix = "g" })
end

-- Default plugin setup
require("nvim-web-devicons").setup()
require("colorizer").setup()
require("which-key").setup()
require("nvim-autopairs").setup({})
require("whitespace-nvim").setup()
vim.keymap.set("n", "<Leader>lt", require("whitespace-nvim").trim) -- Run this on save

gitsigns()
treesitter()
telescope()

cmd()

cursorHoldDiagnostic()
changeLspIcons()

keymappings(client, bufnr)

-- local nvim_lsp = require("lspconfig")
-- -- Nix
-- nvim_lsp.nil_ls.setup({
-- 	on_attach = function(client, bufnr)
-- 		on_attach(client, bufnr)

-- 		-- Let statix format
-- 		client.server_capabilities.document_formatting = false
-- 		client.server_capabilities.document_range_formatting = false
-- 	end,
-- })

-- nvim_lsp.pylsp.setup({
-- 	on_attach = custom_attach,
-- 	settings = {
-- 		pylsp = {
-- 			plugins = {
-- 				-- formatter options
-- 				black = { enabled = true },
-- 				autopep8 = { enabled = false },
-- 				yapf = { enabled = false },
-- 				-- linter options
-- 				-- Run: export PYTHONPATH=$PYTHONPATH:.
-- 				pylint = { enabled = true, executable = "env PYTHONPATH=. pylint" },
-- 				pyflakes = { enabled = false },
-- 				pycodestyle = { enabled = false },
-- 				-- type checker
-- 				pylsp_mypy = { enabled = true },
-- 				-- auto-completion options
-- 				jedi_completion = { fuzzy = true },
-- 				-- import sorting
-- 				pyls_isort = { enabled = true },
-- 			},
-- 		},
-- 	},
-- 	flags = {
-- 		debounce_text_changes = 200,
-- 	},
-- 	capabilities = capabilities,
-- })

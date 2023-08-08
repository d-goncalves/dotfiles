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

function nvim_tree()
	require("nvim-tree").setup({
		sync_root_with_cwd = true,
		respect_buf_cwd = true,
		update_focused_file = { enable = true, update_root = true },
	})

	local whichkey = require("which-key")
	whichkey.register({
		["<leader>e"] = { "<cmd>NvimTreeToggle<cr>", "Tree", noremap = true },
	})
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
	require("neoclip").setup({
		enable_persistent_history = true,
	})
	require("telescope").load_extension("projects")
	require("telescope").load_extension("neoclip")
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

function mason()
	require("mason-null-ls").setup({
		handlers = {},
	})

	local null_ls = require("null-ls")
	null_ls.setup({
		sources = {
			null_ls.builtins.code_actions.gitsigns,
		},
	})
	require("mason").setup()
	require("mason-lspconfig").setup()
	require("mason-lspconfig").setup_handlers({
		function(server_name)
			require("lspconfig")[server_name].setup({})
		end,
	})
end

function null_ls()
	require("mason-null-ls").setup({ handlers = {} })

	local null_ls = require("null-ls")
	null_ls.setup({ sources = { null_ls.builtins.code_actions.gitsigns, null_ls.builtins.formatting.nixpkgs_fmt, } })
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
require("project_nvim").setup({ show_hidden = false, patterns = { ".git" } })
require("whitespace-nvim").setup()
vim.keymap.set("n", "<Leader>lt", require("whitespace-nvim").trim) -- Run this on save

gitsigns()
nvim_tree()
treesitter()
telescope()

null_ls()
cmd()
mason()
null_ls()

cursorHoldDiagnostic()
changeLspIcons()

keymappings(client, bufnr)

local nvim_lsp = require("lspconfig")
-- Nix
nvim_lsp.nil_ls.setup({
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)

		-- Let statix format
		client.server_capabilities.document_formatting = false
		client.server_capabilities.document_range_formatting = false
	end,
})

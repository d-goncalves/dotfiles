-- General Lua Plugin configuration
require("nvim-web-devicons").setup()
require("project_nvim").setup()
require("nvim-tree").setup({
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = true,
	},
})

require("telescope").load_extension("projects")

-- GitSigns configuration {{{

require("gitsigns").setup()

--}}}
-- Colorize {{{

require("colorizer").setup() -- Colorize configuration

----}}}
-- Treesitter {{{
--
require("nvim-treesitter.configs").setup({
	ensure_installed = { "json", "c", "cpp", "cuda", "lua", "python", "yaml" }, -- one of "all", "language", or a list of languages
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = {}, -- list of language that will be disabled
	},

	matchup = {
		enable = true, -- mandatory, false will disable the whole extension
	},
})

-- require'treesitter-context.config'.setup{
--     enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
-- }

-- }}}
-- Todo Comments {{{
require("todo-comments").setup({
	keywords = {
		FIX = { icon = " ", color = "#ff1212", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
		WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
		PERF = { icon = " ", color = "info", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
		NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
		TODO = { icon = " ", color = "#bf6000" },
		HACK = { icon = " ", color = "warning" },
	},
	highlight = {
		before = "", -- "fg" or "bg" or empty
		keyword = "bg", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
		after = "fg", -- "fg" or "bg" or empty
		pattern = [[.*<(KEYWORDS)(\([^\)]*\))?:]],
		comments_only = true, -- uses treesitter to match keywords in comments only
		max_line_len = 400, -- ignore lines longer than this
		exclude = {}, -- list of file types to exclude highlighting
	},
	search = {
		command = "rg",
		args = {
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
		},
		pattern = [[\b(KEYWORDS)(\([^\)]*\))?:]],
	},
})
-- }}}
-- LvimHelper {{{

local home = os.getenv("HOME")
local lvim_helper_bindings = require("lvim-helper.bindings")

require("lvim-helper").setup({
	files = {
		home .. "/.config/nvim/config/plugins/docs/caseSensitive.md",
		home .. "/.config/nvim/config/plugins/docs/changeText.md",
		home .. "/.config/nvim/config/plugins/docs/fileMoviment.md",
		home .. "/.config/nvim/config/plugins/docs/moveFile.md",
		home .. "/.config/nvim/config/plugins/docs/search.md",
		home .. "/.config/nvim/config/plugins/docs/tmux.md",
	},
})

lvim_helper_bindings.bindings = {
	["n"] = lvim_helper_bindings.lvim_helper_callback("next"),
	["p"] = lvim_helper_bindings.lvim_helper_callback("prev"),
	["q"] = lvim_helper_bindings.lvim_helper_callback("close"),
}
--}}}
-- Refactoring {{{
--local refactor = require("refactoring")
--refactor.setup()

---- telescope refactoring helper
--local function refactor(prompt_bufnr)
--    local content = require("telescope.actions.state").get_selected_entry(
--        prompt_bufnr
--    )
--    require("telescope.actions").close(prompt_bufnr)
--    require("refactoring").refactor(content.value)
--end
---- NOTE: M is a global object
---- for the sake of simplicity in this example
---- you can extract this function and the helper above
---- and then require the file and call the extracted function
---- in the mappings below
--M = {}
--M.refactors = function()
--    local opts = require("telescope.themes").get_cursor() -- set personal telescope options
--    require("telescope.pickers").new(opts, {
--        prompt_title = "refactors",
--        finder = require("telescope.finders").new_table({
--            results = require("refactoring").get_refactors(),
--        }),
--        sorter = require("telescope.config").values.generic_sorter(opts),
--        attach_mappings = function(_, map)
--            map("i", "<CR>", refactor)
--            map("n", "<CR>", refactor)
--            return true
--        end
--    }):find()
--end

--vim.api.nvim_set_keymap("v", "<Leader>re", [[ <Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], {noremap = true, silent = true, expr = false})
--vim.api.nvim_set_keymap("v", "<Leader>rf", [[ <Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], {noremap = true, silent = true, expr = false})
--vim.api.nvim_set_keymap("v", "<Leader>rt", [[ <Cmd>lua M.refactors()<CR>]], {noremap = true, silent = true, expr = false})
----}}}
-- Rainbow Brackets {{{

require("nvim-treesitter.configs").setup({
	rainbow = {
		enable = true,
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
	},
})

--}}}

-- Nvim-cmp {{{
-- Setup nvim-cmp.
local cmp = require("cmp")
local lspkind = require("lspkind")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	enabled = function()
		-- disable completion in comments
		local context = require("cmp.config.context")
		-- keep command mode completion enabled when cursor is in a comment
		if vim.api.nvim_get_mode().mode == "c" then
			return true
		else
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
		end
	end,
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	view = {
		entries = { name = "custom", selection_order = "near_cursor" },
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 50,
		}),
		-- format = format,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" }, -- For luasnip users.
		{ name = "calc" },
		{ name = "path" },
		{ name = "nvim_lua" },
	}, {
		{ name = "buffer" },
	}),
})

--}}}
-- Null ls {{{

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

require("null-ls").setup({
	-- you can reuse a shared lspconfig on_attach callback here
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,

	sources = {
		require("null-ls").builtins.diagnostics.actionlint,
		require("null-ls").builtins.diagnostics.cppcheck,
		require("null-ls").builtins.formatting.black,
		require("null-ls").builtins.formatting.clang_format,
		require("null-ls").builtins.diagnostics.flake8,
		require("null-ls").builtins.diagnostics.selene,
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.diagnostics.markdownlint,
		require("null-ls").builtins.diagnostics.write_good,
	},
})

--}}}
-- LSP Config {{{

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"sumneko_lua",
		"rust_analyzer",
		"clangd",
		"bashls",
		"cmake-language-server",
		"dockerfile-language-server",
		"pyright",
		"marksman",
		"flake8",
		"black",
		"luacheck",
		"luaformatter",
		"clang-format",
		"cpplint",
	},
	automatic_installation = true,
})

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>d", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>lD", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>lrn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>lca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "<space>lf", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
	vim.keymap.set("n", "<space>lwa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>lwr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>lwl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
end

capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

require("lspconfig").bashls.setup({ on_attach = on_attach, capabilities = capabilities })
require("lspconfig").clangd.setup({ on_attach = on_attach, capabilities = capabilities })
require("lspconfig").cmake.setup({ on_attach = on_attach, capabilities = capabilities })
require("lspconfig").dockerls.setup({ on_attach = on_attach, capabilities = capabilities })
require("lspconfig").rust_analyzer.setup({ on_attach = on_attach, capabilities = capabilities })
require("lspconfig").pyright.setup({ on_attach = on_attach, capabilities = capabilities })
require("lspconfig").marksman.setup({ on_attach = on_attach, capabilities = capabilities })

require("lspconfig").sumneko_lua.setup({
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

--}}}

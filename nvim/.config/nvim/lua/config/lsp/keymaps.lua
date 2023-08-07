local M = {}

local whichkey = require("which-key")

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
	whichkey.register(keymap_l, { buffer = bufnr, prefix = "<leader>" })
	whichkey.register(keymap_g, { buffer = bufnr, prefix = "g" })
end

function M.setup(client, bufnr)
	keymappings(client, bufnr)
end

return M

local M = {}

function installer()
	require("mason").setup()
	require("mason-lspconfig").setup()
	require("mason-lspconfig").setup_handlers({
		function(server_name)
			require("lspconfig")[server_name].setup({})
		end,
	})
end

function M.setup()
	installer()
    null_ls()
	require("config.lsp.cmp").setup()
	require("config.lsp.null-ls").setup()
	require("config.lsp.lsp").setup()
	require("config.lsp.keymaps").setup()
end

function null_ls ()
    require("mason-null-ls").setup({ handlers = {} })

    local null_ls = require('null-ls')
    null_ls.setup({ sources = { null_ls.builtins.code_actions.gitsigns} })
end
return M

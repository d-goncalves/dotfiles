local M = {}

function M.setup()
	require("mason-null-ls").setup({
		handlers = {},
	})

	local null_ls = require("null-ls")
	null_ls.setup({
		sources = {
			null_ls.builtins.code_actions.gitsigns,
		},
	})
end

return M

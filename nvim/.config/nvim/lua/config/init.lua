local M = {}

function M.setup()
	-- Default plugin setup
	require("nvim-web-devicons").setup()
	require("colorizer").setup()
	require("which-key").setup()
	require("nvim-autopairs").setup({})
	require("project_nvim").setup({ show_hidden = false, patterns = { ".git" } })
	require("whitespace-nvim").setup()
	vim.keymap.set("n", "<Leader>lt", require("whitespace-nvim").trim) -- Run this on save

	require("config.lsp.init").setup()
	require("config.config").setup()
end

return M

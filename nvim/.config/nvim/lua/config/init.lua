local M = {}

function M.setup()
    -- Default plugin setup
    require("nvim-web-devicons").setup()
    require("project_nvim").setup({ show_hidden = false, patterns = { ".git" } })
    require("colorizer").setup()
    require("which-key").setup()

    -- Custom Plugin setup
    require("config.treesitter").setup()
    require("config.gitsigns").setup()
    require("config.lsp.init").setup()
    require("config.todo").setup()
    require("config.telescope").setup()
    require("config.nvim-tree").setup()

end

return M

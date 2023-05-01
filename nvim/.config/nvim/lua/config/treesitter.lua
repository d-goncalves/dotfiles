local M = {}

function M.setup()
    require("nvim-treesitter.configs").setup({
        rainbow = {enable = true, extended_mode = true, max_file_lines = nil}
    })
    require("nvim-treesitter.configs").setup({
        auto_install = true,
        highlight = {
            enable = true -- false will disable the whole extension
        },
        matchup = {
            enable = true -- mandatory, false will disable the whole extension
        }
    })
end

return M

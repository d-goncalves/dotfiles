local M = {}

function M.setup()
    local whichkey = require("which-key")

    require("gitsigns").setup({
        current_line_blame = true
    })

    local keymap_g = {
        g = {
            name = "Git",
            d = {"<cmd>Gitsigns toggle_deleted<cr>", "Deleted"},
            h = {"<cmd>0Gclog<cr>", "History"}
        }
    }
    whichkey.register(keymap_g, {prefix = "<leader>"})
end

return M

local M = {}

function M.setup()
    local whichkey = require("which-key")

    require("gitsigns").setup()

    local keymap_g = {
        g = {
            name = "Git",
            b = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Blame" },
            d = { "<cmd>Gitsigns toggle_deleted<cr>", "Deleted" },
        },
    }
    whichkey.register(keymap_g, { prefix = "<leader>" })
end

return M

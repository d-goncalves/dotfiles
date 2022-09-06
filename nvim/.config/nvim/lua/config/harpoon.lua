local M = {}

function M.setup()
    local whichkey = require("which-key")
    require("harpoon").setup()

    whichkey.register({
        ["<leader>1"] = { "<Cmd>lua require('harpoon.ui').nav_file(1)<CR>", "Harpoon 1" },
        ["<leader>2"] = { "<Cmd>lua require('harpoon.ui').nav_file(2)<CR>", "Harpoon 2" },
        ["<leader>3"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", "Harpoon 3" },
    })

    local keymap_h = {
        h = {
            name = "Harpoon",
            a = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Add Harpoon" },
            m = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Check Harpoon" },
        },
    }
    whichkey.register(keymap_h, { prefix = "<leader>" })
end

return M

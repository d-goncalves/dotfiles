local M = {}

function M.setup()
    local whichkey = require("which-key")

    require("nvim-tree").setup({
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {enable = true, update_root = true},
    })

    whichkey.register({
        ["<leader>e"] = {"<cmd>NvimTreeToggle<cr>", "Tree", noremap = true}
    })
end

return M

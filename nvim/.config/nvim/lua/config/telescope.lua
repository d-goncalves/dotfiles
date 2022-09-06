local M = {}

-- " Saves the current folding state of a file
-- " BUG: This fucks Telescope up
-- " https://github.com/nvim-telescope/telescope.nvim/issues/559
-- " augroup remember_folds
-- "   autocmd!
-- "   autocmd BufWinLeave * mkview
-- "   autocmd BufWinEnter * silent! loadview
-- " augroup END
function M.setup()
    require("neoclip").setup()
    require("telescope").load_extension("projects")
    require("telescope").load_extension("neoclip")
    require("telescope").load_extension("harpoon")
    require("telescope").load_extension("refactoring")
    local whichkey = require("which-key")

    local keymap = {
        f = {
            name = "Find",
            f = { "<cmd>Telescope find_files<cr>", "Find" },
            F = { "<cmd>Telescope find_files hidden=true<cr>", "FindAll" },
            b = { "<cmd>Telescope buffers<cr>", "Buffer" },
            t = { "<cmd>Telescope help_tags<cr>", "Tags" },
            s = { "<cmd>Telescope live_grep<cr>", "Grep" },
            C = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
            c = { "<cmd>Telescope neoclip<cr>", "ClipBoard" },
            P = { "<cmd>Telescope projects<cr>", "Projects" },
            r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
        },
    }

    whichkey.register(keymap, {
        mode = "n",
        prefix = "<leader>",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = false,
    })
end

return M

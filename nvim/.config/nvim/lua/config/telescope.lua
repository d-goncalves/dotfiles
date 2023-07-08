local M = {}

function M.setup()
    require("neoclip").setup()
    require("telescope").load_extension("projects")
    require("telescope").load_extension("neoclip")
    require('telescope').load_extension('fzf')

    require("telescope").setup{
        defaults = {
            theme = 'ivy'
        },
    }
    local whichkey = require("which-key")

    local keymap = {
        f = {
            name = "Find",
            f = { "<cmd>Telescope git_files theme=ivy<cr>", "Find" },
            F = { "<cmd>Telescope find_files hidden=true theme=ivy<cr>", "FindAll" },
            b = { "<cmd>Telescope buffers theme=ivy<cr>", "Buffer" },
            t = { "<cmd>Telescope help_tags theme=ivy<cr>", "Tags" },
            s = { "<cmd>Telescope live_grep theme=ivy<cr>", "Grep" },
            g = { "<cmd>Telescope grep_string theme=ivy<cr>", "Grep" },
            C = { "<cmd>Telescope colorscheme theme=ivy<cr>", "Colorscheme" },
            c = { "<cmd>Telescope neoclip theme=ivy<cr>", "ClipBoard" },
            p = { "<cmd>Telescope projects theme=ivy<cr>", "Projects" },
            h = { "<cmd>Telescope oldfiles theme=ivy<cr>", "Previous Files" }
        }
    }

    whichkey.register(keymap, {
        mode = "n",
        prefix = "<leader>",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = false
    })
end

return M

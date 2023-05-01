local M = {}

function M.setup()
    local whichkey = require("which-key")

    require("todo-comments").setup({
        keywords = {
            FIX = {
                icon = " ",
                color = "#ff1212",
                alt = {"FIXME", "BUG", "FIXIT", "ISSUE"}
            },
            WARN = {icon = " ", color = "warning", alt = {"WARNING", "XXX"}},
            PERF = {
                icon = " ",
                color = "info",
                alt = {"OPTIM", "PERFORMANCE", "OPTIMIZE"}
            },
            NOTE = {icon = " ", color = "hint", alt = {"INFO"}},
            TODO = {icon = " ", color = "#bf6000"},
            HACK = {icon = " ", color = "warning"}
        },
        highlight = {
            before = "", -- "fg" or "bg" or empty
            keyword = "bg", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
            after = "fg", -- "fg" or "bg" or empty
            pattern = [[.*<(KEYWORDS)(\([^\)]*\))?:]],
            comments_only = true, -- uses treesitter to match keywords in comments only
            max_line_len = 400, -- ignore lines longer than this
            exclude = {} -- list of file types to exclude highlighting
        },
        search = {
            command = "rg",
            args = {
                "--color=never", "--no-heading", "--with-filename",
                "--line-number", "--column"
            },
            pattern = [[\b(KEYWORDS)(\([^\)]*\))?:]]
        }
    })

    local keymap_t = {
        t = {
            name = "Todo",
            l = {"<cmd>TodoLocList<cr>", "List"},
            t = {"<cmd>TodoTelescope<cr>", "Telescope"},
            d = {"<cmd>TodoTelescope cwd=%:h<cr>", "Directory"}
        }
    }
    whichkey.register(keymap_t, {prefix = "<leader>"})
end

return M

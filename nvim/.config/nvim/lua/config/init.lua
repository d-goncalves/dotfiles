local M = {}

local function extraKeymaps()
    local whichkey = require("which-key")
    vim.keymap.set("n", "D", ":DogeGenerate<CR>", { noremap = true, silent = true })
    whichkey.register({
        ["<leader>D"] = { "<cmd>DogeGenerate<cr>", "Documentation", noremap = true },
    })
end

function M.setup()
    -- Default plugin setup
    require("nvim-web-devicons").setup()
    require("project_nvim").setup()
    require("colorizer").setup()
    require("which-key").setup()
    require("spellsitter").setup()

    -- Custom Plugin setup
    require("config.treesitter").setup()
    require("config.gitsigns").setup()
    require("config.dap.init").setup()
    require("config.lsp.init").setup()
    require("config.todo").setup()
    require("config.telescope").setup()
    require("config.nvim-tree").setup()
    require("config.harpoon").setup()
    require("config.refactoring").setup()

    extraKeymaps()
end

return M

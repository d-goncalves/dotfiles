local M = {}

function M.setup()
    local whichkey = require("which-key")
    require("refactoring").setup()

    -- Remaps for the refactoring operations currently offered by the plugin
    vim.api.nvim_set_keymap(
        "v",
        "<leader>rf",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
        { noremap = true, silent = true, expr = false }
    )
    vim.api.nvim_set_keymap(
        "v",
        "<leader>re",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
        { noremap = true, silent = true, expr = false }
    )
    vim.api.nvim_set_keymap(
        "v",
        "<leader>rv",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
        { noremap = true, silent = true, expr = false }
    )
    vim.api.nvim_set_keymap(
        "v",
        "<leader>ri",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
        { noremap = true, silent = true, expr = false }
    )

    -- Extract block doesn't need visual mode
    vim.api.nvim_set_keymap(
        "n",
        "<leader>rb",
        [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
        { noremap = true, silent = true, expr = false }
    )
    vim.api.nvim_set_keymap(
        "n",
        "<leader>rE",
        [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
        { noremap = true, silent = true, expr = false }
    )

    -- Inline variable can also pick up the identifier currently under the cursor without visual mode
    vim.api.nvim_set_keymap(
        "n",
        "<leader>ri",
        [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
        { noremap = true, silent = true, expr = false }
    )

    local rename_v = {
        r = {
            name = "Refactoring",
            f = { name = "Extract Funtion" },
            e = { name = "Extract Function to file" },
            v = { name = "Extract Variable" },
            i = { name = "Extract Inline Variable" },
        },
    }
    local rename = {
        r = {
            name = "Refactoring",
            b = { name = "Extract Block" },
            E = { name = "Extract Block to File" },
            i = { name = "Extract Inline Variable" },
        },
    }

    whichkey.register(rename, { prefix = "<leader>" })
    whichkey.register(rename_v, { mode = "v", prefix = "<leader>" })
end

return M

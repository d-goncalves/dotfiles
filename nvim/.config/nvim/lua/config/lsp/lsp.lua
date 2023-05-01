local M = {}

local function cursorHoldDiagnostic()
    -- CursorHold
    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            local opts = {
                focusable = false,
                close_events = {
                    "BufLeave", "CursorMoved", "InsertEnter", "FocusLost"
                },
                border = "rounded",
                source = "always",
                prefix = " ",
                scope = "cursor"
            }
            vim.diagnostic.open_float(nil, opts)
        end
    })
end

local function changeLspIcons()
    local signs = {Error = " ", Warn = " ", Hint = " ", Info = " "}
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
    end
end

local function lspConfigs() local keymaps =
    require("config.lsp.keymaps").setup() end

function M.setup()
    cursorHoldDiagnostic()
    lspConfigs()
    changeLspIcons()
end

return M

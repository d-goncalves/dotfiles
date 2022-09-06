local M = {}

local function cursorHoldDiagnostic()
    -- CursorHold
    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            local opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = "rounded",
                source = "always",
                prefix = " ",
                scope = "cursor",
            }
            vim.diagnostic.open_float(nil, opts)
        end,
    })
end

local function changeLspIcons()
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
end

local function lspConfigs()
    local keymaps = require("config.lsp.keymaps").setup()
    local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

    require("lspconfig").bashls.setup({ on_attach = keymaps, capabilities = capabilities })
    require("lspconfig").clangd.setup({ on_attach = keymaps, capabilities = capabilities })
    require("lspconfig").cmake.setup({ on_attach = keymaps, capabilities = capabilities })
    require("lspconfig").dockerls.setup({ on_attach = keymaps, capabilities = capabilities })
    require("lspconfig").rust_analyzer.setup({ on_attach = keymaps, capabilities = capabilities })
    require("lspconfig").pyright.setup({ on_attach = keymaps, capabilities = capabilities })
    require("lspconfig").marksman.setup({ on_attach = keymaps, capabilities = capabilities })
    require("lspconfig").sumneko_lua.setup({
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                },
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    })
end

local function nvimLuaDev()
    local luadev = require("lua-dev").setup()
    local lspconfig = require("lspconfig")

    lspconfig.sumneko_lua.setup(luadev)
end

function M.setup()
    cursorHoldDiagnostic()
    lspConfigs()
    changeLspIcons()
    nvimLuaDev()
end

return M

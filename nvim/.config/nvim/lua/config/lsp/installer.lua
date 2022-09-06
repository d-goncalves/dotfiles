local M = {}

function M.setup()
    require("mason").setup()
    require("mason-lspconfig").setup({
        -- ensure_installed = {
        --     "sumneko_lua",
        --     "rust_analyzer",
        --     "clangd",
        --     "bashls",
        --     "cmake-language-server",
        --     "dockerfile-language-server",
        --     "pyright",
        --     "marksman",
        --     "flake8",
        --     "black",
        --     "luacheck",
        --     "luaformatter",
        --     "clang-format",
        --     "cpplint",
        -- },
        automatic_installation = true,
    })
end

return M

local M = {}

function M.setup()
    require("config.lsp.installer").setup()
    require("config.lsp.cmp").setup()
    require("config.lsp.null-ls").setup()
    require("config.lsp.lsp").setup()
end

return M

local M = {}

function M.setup()
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    require("null-ls").setup({
        on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
                vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = augroup,
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ bufnr = bufnr })
                    end,
                })
            end
        end,

        sources = {
            require("null-ls").builtins.diagnostics.actionlint,
            require("null-ls").builtins.diagnostics.cppcheck,
            require("null-ls").builtins.formatting.black,
            require("null-ls").builtins.formatting.clang_format,
            require("null-ls").builtins.diagnostics.flake8,
            require("null-ls").builtins.diagnostics.selene,
            require("null-ls").builtins.formatting.stylua,
            require("null-ls").builtins.diagnostics.markdownlint,
            require("null-ls").builtins.diagnostics.write_good,
        },
    })
end

return M

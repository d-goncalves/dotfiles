-- yaml-language-server, extended by schema-companion so <leader>fy can pick a schema.
-- This file has to live in after/lsp so nothing else overrides it.
return require("schema-companion").setup_client(
    require("schema-companion").adapters.yamlls.setup({
        sources = { require("schema-companion").sources.lsp.setup() },
    }),
    {}
)

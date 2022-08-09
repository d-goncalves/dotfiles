-- General Lua Plugin configuration

-- -- Plugin: Indent blankline {{{

-- -- vim.opt.termguicolors = true
-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 blend=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B blend=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 blend=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 blend=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF blend=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD blend=nocombine]]

-- vim.opt.list = true
-- vim.opt.listchars = {
--     space = "⋅",
--     eol = "↴",
-- }

-- require("indent_blankline").setup {
--     space_char_blankline = " ",
--     char_highlight_list = {
--         "IndentBlanklineIndent1",
--         "IndentBlanklineIndent2",
--         "IndentBlanklineIndent3",
--         "IndentBlanklineIndent4",
--         "IndentBlanklineIndent5",
--         "IndentBlanklineIndent6",
--     },
-- }

-- -- }}}
-- GitSigns configuration {{{

require('gitsigns').setup()

--}}}
---- Colorize {{{

--require'colorizer'.setup() -- Colorize configuration

----}}}
-- Treesitter {{{
            --
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "typescript", "json", "c", "cpp", "cuda", "dockerfile", "latex", "lua", "php", "python", "vue", "yaml"},    -- one of "all", "language", or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { },  -- list of language that will be disabled
  },

    matchup = {
        enable = true,              -- mandatory, false will disable the whole extension
      },
}

-- require'treesitter-context.config'.setup{
--     enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
-- }

-- }}}
-- Todo Comments {{{
require("todo-comments").setup {
    keywords = {
        FIX  = { icon = " ", color = "#ff1212", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", color = "info",    alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint",    alt = { "INFO" } },
        TODO = { icon = " ", color = "#bf6000" },
        HACK = { icon = " ", color = "warning" },
    },
    highlight = {
      before = "", -- "fg" or "bg" or empty
      keyword = "bg", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
      after = "fg", -- "fg" or "bg" or empty
      pattern = [[.*<(KEYWORDS)(\([^\)]*\))?:]],
      comments_only = true, -- uses treesitter to match keywords in comments only
      max_line_len = 400, -- ignore lines longer than this
      exclude = {}, -- list of file types to exclude highlighting
    },
    search = {
        command = "rg",
        args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
        },
        pattern = [[\b(KEYWORDS)(\([^\)]*\))?:]],
    },
}
-- }}}
-- LvimHelper {{{

local home = os.getenv('HOME')
local lvim_helper_bindings = require('lvim-helper.bindings');

require('lvim-helper').setup({
    files = {
        home .. '/.config/nvim/docs/caseSensitive.md',
        home .. '/.config/nvim/docs/changeText.md',
        home .. '/.config/nvim/docs/fileMoviment.md',
        home .. '/.config/nvim/docs/moveFile.md',
        home .. '/.config/nvim/docs/search.md',
        home .. '/.config/nvim/docs/tmux.md',
    }
})

lvim_helper_bindings.bindings = {
    ["n"] = lvim_helper_bindings.lvim_helper_callback("next"),
    ["p"] = lvim_helper_bindings.lvim_helper_callback("prev"),
    ["q"] = lvim_helper_bindings.lvim_helper_callback("close")
}
--}}}
---- Refactoring {{{
--local refactor = require("refactoring")
--refactor.setup()

---- telescope refactoring helper
--local function refactor(prompt_bufnr)
--    local content = require("telescope.actions.state").get_selected_entry(
--        prompt_bufnr
--    )
--    require("telescope.actions").close(prompt_bufnr)
--    require("refactoring").refactor(content.value)
--end
---- NOTE: M is a global object
---- for the sake of simplicity in this example
---- you can extract this function and the helper above
---- and then require the file and call the extracted function
---- in the mappings below
--M = {}
--M.refactors = function()
--    local opts = require("telescope.themes").get_cursor() -- set personal telescope options
--    require("telescope.pickers").new(opts, {
--        prompt_title = "refactors",
--        finder = require("telescope.finders").new_table({
--            results = require("refactoring").get_refactors(),
--        }),
--        sorter = require("telescope.config").values.generic_sorter(opts),
--        attach_mappings = function(_, map)
--            map("i", "<CR>", refactor)
--            map("n", "<CR>", refactor)
--            return true
--        end
--    }):find()
--end

--vim.api.nvim_set_keymap("v", "<Leader>re", [[ <Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], {noremap = true, silent = true, expr = false})
--vim.api.nvim_set_keymap("v", "<Leader>rf", [[ <Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], {noremap = true, silent = true, expr = false})
--vim.api.nvim_set_keymap("v", "<Leader>rt", [[ <Cmd>lua M.refactors()<CR>]], {noremap = true, silent = true, expr = false})
----}}}
-- Rainbow Brackets {{{
require'nvim-treesitter.configs'.setup {
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}
--}}}

-- LSP Config {{{

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local function config(_config)
    return vim.tbl_deep_extend("force", {
        -- capabilities = capabilities
        on_attach = function()
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
            vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
            vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
            vim.keymap.set('n', '<space>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, bufopts)
            vim.keymap.set('n', '<space>gt', vim.lsp.buf.type_definition, bufopts)
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
            vim.keymap.set('n', '<space>lca', vim.lsp.buf.code_action, bufopts)
            vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)

        end,
	}, _config or {})
end

require'lspconfig'.clangd.setup(config())
require'lspconfig'.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

--}}}

-- Null ls {{{
-- require("null-ls").setup({
--   sources = {
--     require("null-ls").builtins.diagnostics.actionlint,
--     require("null-ls").builtins.diagnostics.cppcheck,
--   },
-- })

--}}}

-- Setup nvim-cmp.
local cmp = require('cmp')

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
    }, {
        { name = 'buffer' },
    })
})

-- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
--     sources = cmp.config.sources({
--         { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
--     }, {
--         { name = 'buffer' },
--     })
-- })


-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
    capabilities = capabilities
}

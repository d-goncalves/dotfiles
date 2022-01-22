-- General Lua Plugin configuration

-- GitSigns configuration {{{

require('gitsigns').setup()

--}}}
---- Colorize {{{

--require'colorizer'.setup() -- Colorize configuration

----}}}
-- Treesitter {{{
            --
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"json", "c", "cpp", "cuda", "lua", "python", "yaml"},    -- one of "all", "language", or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { },  -- list of language that will be disabled
  },

    matchup = {
        enable = true,              -- mandatory, false will disable the whole extension
      },
}

require'treesitter-context.config'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
}

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

require'colorizer'.setup() -- Colorize configuration
require('gitsigns').setup()


-- Telescope setup
require('telescope').setup {
  extensions = {
   fzf = {
    fuzzy = true,                    -- false will only do exact matching
    override_generic_sorter = false, -- override the generic sorter
    override_file_sorter = true,     -- override the file sorter
    }
  }
}
require('telescope').load_extension('coc')
require('telescope').load_extension('fzf')

-- Tree sitter configuration
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

require'treesitter-context.config'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
}

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

vim = vim -- trick to make LSP understand that vim is a global variable
local map = vim.api.nvim_set_keymap
local autocmd = vim.api.nvim_create_autocmd

vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup()
        end,
    },
    { "folke/neoconf.nvim", cmd = "Neoconf" },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.4",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-github.nvim",
            "nvim-telescope/telescope-project.nvim",
            "nvim-telescope/telescope-github.nvim",
            "folke/which-key.nvim",
        },
        config = function()
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("project")
            require("telescope").load_extension("git_worktree")
            require("telescope").load_extension("gh")
            require("telescope").setup()

            local keymap = {
                f = {
                    name = "Find",
                    f = { "<cmd>Telescope git_files theme=ivy<cr>", "Find" },
                    F = { "<cmd>Telescope find_files hidden=true theme=ivy<cr>", "FindAll" },
                    b = { "<cmd>Telescope buffers theme=ivy<cr>", "Buffer" },
                    t = { "<cmd>Telescope help_tags theme=ivy<cr>", "Tags" },
                    s = { "<cmd>Telescope live_grep theme=ivy<cr>", "Grep" },
                    g = { "<cmd>Telescope grep_string theme=ivy<cr>", "Grep" },
                    C = { "<cmd>Telescope colorscheme theme=ivy<cr>", "Colorscheme" },
                    c = { "<cmd>Telescope neoclip theme=ivy<cr>", "ClipBoard" },
                    p = { "<cmd>Telescope project theme=ivy<cr>", "Projects" },
                    h = { "<cmd>Telescope oldfiles theme=ivy<cr>", "Previous Files" },
                },
            }

            local whichkey = require("which-key")
            whichkey.register(keymap, {
                mode = "n",
                prefix = "<leader>",
                buffer = nil,
                silent = true,
                noremap = true,
                nowait = false,
            })
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        dependencies = {},
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = { "p00f/nvim-ts-rainbow", "romgrk/nvim-treesitter-context" },
        config = function()
            require("nvim-treesitter.configs").setup({
                rainbow = { enable = true, extended_mode = true, max_file_lines = nil },
                auto_install = true,
                highlight = { enable = true },
                matchup = { enable = true },
            })
        end,
    },

    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup()
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({})
                end,
            })
        end,
    },
    "neovim/nvim-lspconfig",
    { "folke/neodev.nvim",  opts = {} },
    {
        "mrcjkb/haskell-tools.nvim",
        version = "^3",
        ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    },

    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-calc",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
            { "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind.nvim",
        },
    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "jose-elias-alvarez/null-ls.nvim",
        },
        config = function()
            require("mason-null-ls").setup({
                ensure_installed = {},
                automatic_installation = true,
                handlers = {},
            })
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.nixfmt,
                    null_ls.builtins.diagnostics.statix,
                },
            })
            for type, icon in pairs({ Error = " ", Warn = " ", Hint = " ", Info = " " }) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
        end,
    },

    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    "ThePrimeagen/git-worktree.nvim",
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({ current_line_blame = true })

            function ToggleBlame()
                if string.find(vim.bo.filetype, "fugitive") then
                    vim.api.nvim_buf_delete(0, {})
                else
                    vim.cmd("Git blame")
                end
            end

            local whichkey = require("which-key")
            local keymap_g = {
                g = {
                    name = "Git",
                    b = { "<cmd>lua ToggleBlame()<CR>", "Blame" },
                    d = { "<cmd>Gitsigns toggle_deleted<cr>", "Deleted" },
                    h = { "<cmd>0Gclog<cr>", "History" },
                    c = { "<cmd>.GBrowse<CR>", "Open Github" },
                },
            }
            whichkey.register(keymap_g, { prefix = "<leader>" })
        end,
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    {
        "kyazdani42/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup()
        end,
    },
    {
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    },
    {
        "johnfrankmorgan/whitespace.nvim",
        config = function()
            require("whitespace-nvim").setup()
            vim.keymap.set("n", "<Leader>lt", require("whitespace-nvim").trim)
        end,
    },

    "terryma/vim-expand-region",
    "tpope/vim-surround",
    "tpope/vim-commentary",
    "tpope/vim-repeat",
    "coderifous/textobj-word-column.vim",
    "andymass/vim-matchup",
    "wellle/targets.vim",
    "AndrewRadev/splitjoin.vim",
    "junegunn/vim-easy-align",
    "justinmk/vim-gtfo",
    "romainl/vim-cool",
    "markonm/traces.vim",
    "direnv/direnv.vim",
    "itchyny/vim-cursorword",
    "lukas-reineke/indent-blankline.nvim",
    "christoomey/vim-tmux-navigator",
    "folke/which-key.nvim",
    "gruvbox-community/gruvbox",
    "Everblush/nvim",
    "bluz71/vim-moonfly-colors",
    "zootedb0t/citruszest.nvim",
    {
        "sekke276/dark_flat.nvim",
        config = function()
            require("dark_flat").setup({
                transparent = true,
            })
        end,
    },
    "dasupradyumna/midnight.nvim",
    "yazeed1s/minimal.nvim",
    {
        "cpea2506/one_monokai.nvim",
        config = function()
            require("one_monokai").setup({
                transparent = true,
            })
        end,
    },
})

vim.cmd.colorscheme("dark_flat")

vim.opt.scrolloff = 5
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.timeoutlen = 500
vim.opt.clipboard = "unnamedplus"
vim.opt.shortmess:append("c")
vim.opt.whichwrap:append("h,l")
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.conceallevel = 0
vim.opt.showtabline = 0
vim.opt.laststatus = 0
vim.opt.pumheight = 10
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 20
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.softtabstop = 0

-- vim.opt.formatoptions-="cro"

map("", "<C-c>", "<Esc>", { noremap = true, silent = false })
map("", "1", "^", {})
map("", "0", "$", {})
map("i", "jk", "<Esc>", { noremap = true, silent = false })
map("n", "<C-s>", ":up", { noremap = true, silent = false })
map("n", "<C-q>", ":wq<cr>", { noremap = true, silent = false })
map("n", "<C-d>", "<C-d>zz", { noremap = true, silent = false })
map("n", "<C-u>", "<C-u>zz", { noremap = true, silent = false })
map("v", "<", "<gv", { noremap = true, silent = false })
map("v", ">", ">gv", { noremap = true, silent = false })
map("v", "<leader>r", '"hy:%s/<C-r>h//g<left><left>', { noremap = true, silent = false })

autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.hcl.j2", command = "set ft=hcl.jinja2" })
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.timer", command = "set ft=systemd" })
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.service", command = "set ft=systemd" })
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.timer.j2", command = "set ft=systemd.jinja2" })
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.service.j2", command = "set ft=systemd.jinja2" })
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.json.j2", command = "set ft=json.jinja2" })
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.yml.j2", command = "set ft=yaml.jinja2" })
autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
        local opts = {
            focusable = false,
            close_events = {
                "BufLeave",
                "CursorMoved",
                "InsertEnter",
                "FocusLost",
            },
            border = "rounded",
            source = "always",
            prefix = " ",
            scope = "cursor",
        }
        vim.diagnostic.open_float(nil, opts)
    end,
})

local cmp = require("cmp")

cmp.setup({
    enabled = function()
        -- disable autocompletion in prompt (wasn't playing good with telescope)
        buftype = vim.api.nvim_buf_get_option(0, "buftype")
        if buftype == "prompt" then
            return false
        end
        local context = require("cmp.config.context")
        -- disable autocompletion in comments
        return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
    end,
    view = { entries = { name = "custom", selection_order = "near_cursor" } },
    formatting = { format = require("lspkind").cmp_format({ maxwidth = 50 }) },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "calc" },
        { name = "path" },
        { name = "nvim_lua" },
        { name = "cmp_cmdline" },
        { name = "nvim_lsp_signature_help" },
    }, { { name = "buffer" } }),
})
local opts = { noremap = true, silent = true }

-- Key mappings
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

-- Whichkey
local keymap_l = {
    l = {
        name = "Language",
        r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
        a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
        d = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Line Diagnostics" },
        i = { "<cmd>LspInfo<CR>", "Lsp Info" },
        f = { "<cmd>lua vim.lsp.buf.format({bufnr = bufnr})<CR>", "Format Document" },
    },
}

local keymap_g = {
    name = "LSP Goto",
    d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
    r = { "<Cmd>lua vim.lsp.buf.references()<CR>", "References" },
    D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
    s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
    I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation" },
    t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" },
}
local whichkey = require("which-key")
whichkey.register(keymap_l, { buffer = bufnr, prefix = "<leader>" })
whichkey.register(keymap_g, { buffer = bufnr, prefix = "g" })

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
    { "folke/neoconf.nvim",     cmd = "Neoconf" },
    "folke/neodev.nvim",
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",

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
            require("telescope").load_extension("project")
            require("telescope").load_extension("git_worktree")
            require("telescope").load_extension("gh")
            require("telescope").setup()

            local whichkey = require("which-key")
            whichkey.add({
                { "<leader>f",  group = "Find",                                        nowait = false, remap = false },
                { "<leader>ff", "<cmd>Telescope git_files theme=ivy<cr>",              nowait = false, remap = false },
                { "<leader>fF", "<cmd>Telescope find_files hidden=true theme=ivy<cr>", nowait = false, remap = false },
                { "<leader>fb", "<cmd>Telescope buffers theme=ivy<cr>",                nowait = false, remap = false },
                { "<leader>ft", "<cmd>Telescope help_tags theme=ivy<cr>",              nowait = false, remap = false },
                { "<leader>fs", "<cmd>Telescope live_grep theme=ivy<cr>",              nowait = false, remap = false },
                { "<leader>fg", "<cmd>Telescope grep_string theme=ivy<cr>",            nowait = false, remap = false },
                { "<leader>fC", "<cmd>Telescope colorscheme theme=ivy<cr>",            nowait = false, remap = false },
                { "<leader>fc", "<cmd>Telescope neoclip theme=ivy<cr>",                nowait = false, remap = false },
                { "<leader>fp", "<cmd>Telescope project theme=ivy<cr>",                nowait = false, remap = false },
                { "<leader>fh", "<cmd>Telescope oldfiles theme=ivy<cr>",               nowait = false, remap = false },
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
        "dundalek/lazy-lsp.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
        },
        config = function()
            local lsp_zero = require("lsp-zero")

            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings to learn the available actions
                lsp_zero.default_keymaps({
                    buffer = bufnr,
                    preserve_mappings = false
                })
            end)

            require("lazy-lsp").setup {
                excluded_servers = {
                    "basedpyright",
                    "pylyzer",
                }
            }
        end,
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
            whichkey.add({
                { "<leader>g",  group = "Git",                      nowait = false, remap = false },
                { "<leader>gb", "<cmd>lua ToggleBlame()<CR>",       nowait = false, remap = false },
                { "<leader>gd", "<cmd>Gitsigns toggle_deleted<cr>", nowait = false, remap = false },
                { "<leader>gh", "<cmd>0Gclog<cr>",                  nowait = false, remap = false },
                { "<leader>gc", "<cmd>.GBrowse<CR>",                nowait = false, remap = false },
            })
        end,
    },
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    "ThePrimeagen/git-worktree.nvim",
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
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    { 'echasnovski/mini.icons', version = false },
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
    "direnv/direnv.vim",
    "itchyny/vim-cursorword",
    "lukas-reineke/indent-blankline.nvim",
    "christoomey/vim-tmux-navigator",
    "folke/which-key.nvim",
    "gruvbox-community/gruvbox",
    "Everblush/nvim",
    {
        "sekke276/dark_flat.nvim",
        config = function()
            require("dark_flat").setup({
                transparent = true,
            })
        end,
    },
    {
        'codota/tabnine-nvim',
        build = "./dl_binaries.sh",
        config = function()
            require('tabnine').setup({
                disable_auto_comment = true,
                accept_keymap = "<S-tab>",
                debounce_ms = 800,
                exclude_filetypes = { "TelescopePrompt", "NvimTree" },
                log_file_path = nil, -- absolute path to Tabnine log file
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
map("n", "ga", "<Plug>(EasyAlign)", { noremap = true, silent = false })
map("x", "ga", "<Plug>(EasyAlign)", { noremap = true, silent = false })

autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.tftpl", command = "set ft=terraform.hcl" })
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

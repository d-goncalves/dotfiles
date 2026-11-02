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
    "folke/lazydev.nvim",
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-github.nvim",
            "nvim-telescope/telescope-project.nvim",
            "nvim-telescope/telescope-github.nvim",
            "folke/which-key.nvim",
        },
        config = function()
            require("telescope").load_extension("gh")
            require("telescope").load_extension("git_worktree")
            require("telescope").load_extension("project")
            require("telescope").setup()
            local whichkey = require("which-key")
            whichkey.add({
                { "<leader>fy", "<cmd>Telescope yaml_schema <cr>",            nowait = false, remap = false },
                { "<leader>ff", "<cmd>Telescope git_files <cr>",              nowait = false, remap = false },
                { "<leader>fF", "<cmd>Telescope find_files hidden=true <cr>", nowait = false, remap = false },
                { "<leader>fb", "<cmd>Telescope buffers <cr>",                nowait = false, remap = false },
                { "<leader>ft", "<cmd>Telescope help_tags <cr>",              nowait = false, remap = false },
                { "<leader>fs", "<cmd>Telescope live_grep <cr>",              nowait = false, remap = false },
                { "<leader>fg", "<cmd>Telescope grep_string <cr>",            nowait = false, remap = false },
                { "<leader>fG", "<cmd>Telescope git_status <cr>",             nowait = false, remap = false },
                { "<leader>fC", "<cmd>Telescope colorscheme <cr>",            nowait = false, remap = false },
                { "<leader>fc", "<cmd>Telescope neoclip <cr>",                nowait = false, remap = false },
                { "<leader>fp", "<cmd>Telescope project <cr>",                nowait = false, remap = false },
                { "<leader>fh", "<cmd>Telescope oldfiles <cr>",               nowait = false, remap = false },
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
        branch = "master",
        build = ":TSUpdate",
        -- dependencies = { "p00f/nvim-ts-rainbow", "romgrk/nvim-treesitter-context" },
        config = function()
            require("nvim-treesitter.configs").setup({
                -- rainbow = { enable = true, extended_mode = true, max_file_lines = nil },
                auto_install = true,
                highlight = { enable = true },
                matchup = { enable = true },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
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
    {
        "gbprod/substitute.nvim",
        config = function()
            require("substitute").setup()
            vim.keymap.set("n", "s", require('substitute').operator, { noremap = true })
            vim.keymap.set("n", "ss", require('substitute').line, { noremap = true })
            vim.keymap.set("n", "S", require('substitute').eol, { noremap = true })
            vim.keymap.set("x", "s", require('substitute').visual, { noremap = true })
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

    -- "gruvbox-community/gruvbox",
    -- "sainnhe/gruvbox-material",
    -- "ellisonleao/gruvbox.nvim",
    -- "luisiacc/gruvbox-baby",
    -- "Everblush/nvim",
    -- "ficcdaf/ashen.nvim",
    -- "scottmckendry/cyberdream.nvim",
    -- {
    --     "cpea2506/one_monokai.nvim",
    --     config = function()
    --         require("one_monokai").setup({
    --             transparent = true,
    --         })
    --     end,
    -- },
    {
        "sekke276/dark_flat.nvim",
        config = function()
            require("dark_flat").setup({
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
vim.opt.number = false
vim.opt.relativenumber = false
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
vim.opt.cursorline = false
vim.opt.conceallevel = 0
vim.opt.showtabline = 0
-- vim.opt.laststatus = 0
vim.opt.statusline = "%F"
vim.opt.pumheight = 10
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 20
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.softtabstop = 0
vim.opt.autoread = true

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


vim.lsp.enable('ty')
vim.lsp.enable("lua_ls")
vim.lsp.enable("pylsp")
vim.lsp.enable("pyright")
vim.lsp.enable("ty")
vim.lsp.enable("terraformls")
-- vim.lsp.enable("ansiblels")
vim.lsp.enable("bashls")
vim.lsp.enable("clangd")
vim.lsp.enable("docker_compose_language_service")
vim.lsp.enable("tflint")
vim.lsp.enable("dhall_lsp_server")
vim.lsp.enable("nil_ls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("typos_lsp")

vim.filetype.add({
    filename = {
        ["docker-compose.yml"] = "yaml.docker-compose",
        ["docker-compose.yaml"] = "yaml.docker-compose",
        ["compose.yml"] = "yaml.docker-compose",
        ["compose.yaml"] = "yaml.docker-compose",
    },
    pattern = {
        [".*/.*playbook.*.ya?ml"] = "yaml.ansible",
        [".*/.*tasks.*/.*ya?ml"] = "yaml.ansible",
        [".*/local.ya?ml"] = "yaml.ansible",
        ["*.yaml.j2"] = "yaml.jinja2",
        ["*.yml.j2"] = "yaml.jinja2",
    },

})

autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.tftpl", command = "set ft=terraform.hcl" })
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.hcl.j2", command = "set ft=hcl.jinja2" })
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.timer", command = "set ft=systemd" })
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.service", command = "set ft=systemd" })
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.timer.j2", command = "set ft=systemd.jinja2" })
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.service.j2", command = "set ft=systemd.jinja2" })
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.json.j2", command = "set ft=json.jinja2" })
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.yml.j2", command = "set ft=yaml.jinja2" })
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.yaml.j2", command = "set ft=yaml.jinja2" })
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

vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = { current_line = true },
  underline = true,
  update_in_insert = false
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})

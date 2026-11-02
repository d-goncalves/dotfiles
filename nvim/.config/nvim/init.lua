-- Neovim config. Plugins are managed by lazy.nvim, which bootstraps itself below.

vim.g.mapleader = " "
vim.opt.termguicolors = true -- some plugins (colorizer) check this while loading

-- ── Plugin manager ────────────────────────────────────────────────────────────
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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

-- ── Plugins ───────────────────────────────────────────────────────────────────
require("lazy").setup({
    { "folke/neoconf.nvim", cmd = "Neoconf" },
    "folke/lazydev.nvim",
    {
        "nvim-telescope/telescope.nvim",
        tag = "v0.2.2",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-github.nvim",
            "nvim-telescope/telescope-project.nvim",
            "folke/which-key.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup()
            telescope.load_extension("fzf")
            telescope.load_extension("gh")
            telescope.load_extension("git_worktree")
            telescope.load_extension("project")
            require("which-key").add({
                { "<leader>fy", function() require("schema-companion").select_schema() end },
                { "<leader>ff", "<cmd>Telescope git_files <cr>" },
                { "<leader>fF", "<cmd>Telescope find_files hidden=true <cr>" },
                { "<leader>fb", "<cmd>Telescope buffers <cr>" },
                { "<leader>ft", "<cmd>Telescope help_tags <cr>" },
                { "<leader>fs", "<cmd>Telescope live_grep <cr>" },
                { "<leader>fg", "<cmd>Telescope grep_string <cr>" },
                { "<leader>fG", "<cmd>Telescope git_status <cr>" },
                { "<leader>fC", "<cmd>Telescope colorscheme <cr>" },
                { "<leader>fc", "<cmd>Telescope neoclip <cr>" },
                { "<leader>fp", "<cmd>Telescope project <cr>" },
                { "<leader>fh", "<cmd>Telescope oldfiles <cr>" },
            })
        end,
    },
    {
        "AckslD/nvim-neoclip.lua",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("neoclip").setup()
            require("telescope").load_extension("neoclip")
        end,
    },
    {
        "cenk1cenk2/schema-companion.nvim", -- YAML schema picker (<leader>fy); wired up in after/lsp/yamlls.lua
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false, -- the main branch does not support lazy-loading
        build = ":TSUpdate",
        config = function()
            local ts = require("nvim-treesitter")
            ts.setup()

            -- Highlighting is built into neovim. Start it for every file type that has a
            -- parser, installing the parser first when it is missing (what auto_install did).
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(ev)
                    local lang = vim.treesitter.language.get_lang(ev.match)
                    if not lang then
                        return
                    end
                    local function start()
                        if vim.api.nvim_buf_is_valid(ev.buf) then
                            pcall(vim.treesitter.start, ev.buf, lang)
                        end
                    end
                    if vim.list_contains(ts.get_installed(), lang) then
                        start()
                    elseif vim.list_contains(ts.get_available(), lang) then
                        ts.install(lang):await(function()
                            vim.schedule(start)
                        end)
                    end
                end,
            })
        end,
    },
    "neovim/nvim-lspconfig",
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({ current_line_blame = true })

            require("which-key").add({
                { "<leader>g", group = "Git" },
                {
                    "<leader>gb",
                    function()
                        if string.find(vim.bo.filetype, "fugitive") then
                            vim.api.nvim_buf_delete(0, {})
                        else
                            vim.cmd("Git blame")
                        end
                    end,
                },
                { "<leader>gd", "<cmd>Gitsigns toggle_deleted<cr>" },
                { "<leader>gh", "<cmd>0Gclog<cr>" },
                { "<leader>gc", "<cmd>.GBrowse<CR>" },
            })
        end,
    },
    {
        "gbprod/substitute.nvim",
        config = function()
            local substitute = require("substitute")
            substitute.setup()
            vim.keymap.set("n", "s", substitute.operator)
            vim.keymap.set("n", "ss", substitute.line)
            vim.keymap.set("n", "S", substitute.eol)
            vim.keymap.set("x", "s", substitute.visual)
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
    { "nvim-mini/mini.icons", version = false },
    {
        "nvim-tree/nvim-web-devicons",
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
    { "folke/which-key.nvim", opts = {} }, -- opts makes lazy.nvim call setup(), which activates the <leader> mappings added above
    {
        "sekke276/dark_flat.nvim",
        config = function()
            require("dark_flat").setup({
                transparent = true,
            })
        end,
    },
}, {
    rocks = { enabled = false }, -- none of these plugins need luarocks
})

-- ── Options ───────────────────────────────────────────────────────────────────
vim.cmd.colorscheme("dark_flat")
vim.opt.scrolloff = 5
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.number = false
vim.opt.relativenumber = false
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
vim.opt.statusline = "%F"
vim.opt.pumheight = 10
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 20
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.softtabstop = 0
vim.opt.autoread = true

-- ── Mappings ──────────────────────────────────────────────────────────────────
local map = vim.keymap.set

map("", "<C-c>", "<Esc>")
map("", "1", "^", { remap = true })
map("", "0", "$", { remap = true })
map("i", "jk", "<Esc>")
map("n", "<C-s>", ":up")
map("n", "<C-q>", ":wq<cr>")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "<leader>r", '"hy:%s/<C-r>h//g<left><left>')
map({ "n", "x" }, "ga", "<Plug>(EasyAlign)", { remap = true }) -- <Plug> mappings need remap

-- ── Language servers ──────────────────────────────────────────────────────────
-- Only servers that are installed on this machine get enabled, so a missing one is skipped
-- quietly instead of raising an error (the install list is in Brewfile.extras)
local language_servers = {
    "ty",
    "lua_ls",
    "pylsp",
    "pyright",
    "terraformls",
    "bashls",
    "clangd",
    "docker_compose_language_service",
    "tflint",
    "dhall_lsp_server",
    "nil_ls",
    "ts_ls",
    "rust_analyzer",
    "typos_lsp",
    "yamlls",
}
vim.lsp.config("terraformls", { init_options = { ignoreSingleFileWarning = true } })
for _, name in ipairs(language_servers) do
    local cmd = vim.lsp.config[name] and vim.lsp.config[name].cmd
    if type(cmd) ~= "table" or vim.fn.executable(cmd[1]) == 1 then
        vim.lsp.enable(name)
    end
end

vim.diagnostic.config({
    virtual_text = true,
    virtual_lines = { current_line = true },
    underline = true,
    update_in_insert = false,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})

-- ── Filetypes ─────────────────────────────────────────────────────────────────
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

local filetype_by_pattern = {
    { "*.tftpl", "terraform.hcl" },
    { "*.hcl.j2", "hcl.jinja2" },
    { "*.timer", "systemd" },
    { "*.service", "systemd" },
    { "*.timer.j2", "systemd.jinja2" },
    { "*.service.j2", "systemd.jinja2" },
    { "*.json.j2", "json.jinja2" },
    { "*.yml.j2", "yaml.jinja2" },
    { "*.yaml.j2", "yaml.jinja2" },
}
for _, entry in ipairs(filetype_by_pattern) do
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = entry[1],
        command = "set ft=" .. entry[2],
    })
end

-- ── Autocommands ──────────────────────────────────────────────────────────────
-- Show the diagnostic under the cursor in a floating window
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = "rounded",
            source = "always",
            prefix = " ",
            scope = "cursor",
        })
    end,
})

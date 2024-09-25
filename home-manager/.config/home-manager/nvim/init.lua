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
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x',
        lazy = true,
        config = false,
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
        config = function()
            local cmp = require('cmp')

            cmp.setup({
                sources = {
                    { name = 'nvim_lsp' },
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                }),
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
        },
        config = function()
            local lsp_zero = require('lsp-zero')

            -- lsp_attach is where you enable features that only work
            -- if there is a language server active in the file
            local lsp_attach = function(client, bufnr)
                local opts = { buffer = bufnr }

                vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
            end

            lsp_zero.extend_lspconfig({
                sign_text = true,
                lsp_attach = lsp_attach,
                capabilities = require('cmp_nvim_lsp').default_capabilities()
            })
            require('lspconfig').terraformls.setup {}
            require('lspconfig').lua_ls.setup({})

            require 'lspconfig'.statix.setup {}
            require('lspconfig').pylsp.setup {}
            require('lspconfig').pyright.setup {}
            require 'lspconfig'.ansiblels.setup {}
            require 'lspconfig'.bashls.setup {}
            require 'lspconfig'.clangd.setup {}
            require 'lspconfig'.docker_compose_language_service.setup {}
            require 'lspconfig'.tflint.setup {}
            require 'lspconfig'.nginx_language_server.setup {}
            require 'lspconfig'.dockerls.setup {}
            require 'lspconfig'.dhall_lsp_server.setup {}
            require 'lspconfig'.nil_ls.setup {}
            require 'lspconfig'.ts_ls.setup {}
            require('lspconfig').yamlls.setup {
                settings = {
                    yaml = {
                        schemas = {
                            ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
                            ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                        },
                    },
                }
            }

            require 'lspconfig'.lua_ls.setup {
                on_init = function(client)
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                            return
                        end
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                        runtime = {
                            -- Tell the language server which version of Lua you're using
                            -- (most likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT'
                        },
                        -- Make the server aware of Neovim runtime files
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME
                                -- Depending on the usage, you might want to add additional paths here.
                                -- "${3rd}/luv/library"
                                -- "${3rd}/busted/library",
                            }
                            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                            -- library = vim.api.nvim_get_runtime_file("", true)
                        }
                    })
                    -- Configuration ends here --
                end,
                settings = {
                    Lua = {}
                }
            }
        end
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
    "sainnhe/gruvbox-material",
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

vim.cmd.colorscheme("gruvbox-material")

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
vim.opt.cursorline = false
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

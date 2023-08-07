local M = {}

function M.setup()
	gitsigns()
	nvim_tree()
	treesitter()
	telescope()
end

function gitsigns()
	local whichkey = require("which-key")

	require("gitsigns").setup({ current_line_blame = true })

	local keymap_g = {
		g = {
			name = "Git",
			b = { "<cmd>call ToggleBlame()<CR>", "Blame" },
			d = { "<cmd>Gitsigns toggle_deleted<cr>", "Deleted" },
			h = { "<cmd>0Gclog<cr>", "History" },
			c = { "<cmd>.GBrowse<CR>", "Open Github" },
		},
	}
	whichkey.register(keymap_g, { prefix = "<leader>" })
end

function nvim_tree()
	-- vim.g.loaded_netrw = 1
	-- vim.g.loaded_netrwPlugin = 1
	local whichkey = require("which-key")

	require("nvim-tree").setup({
		sync_root_with_cwd = true,
		respect_buf_cwd = true,
		update_focused_file = { enable = true, update_root = true },
	})

	whichkey.register({
		["<leader>e"] = { "<cmd>NvimTreeToggle<cr>", "Tree", noremap = true },
	})
end

function treesitter()
	require("nvim-treesitter.configs").setup({
		rainbow = { enable = true, extended_mode = true, max_file_lines = nil },
		auto_install = true,
		highlight = { enable = true },
		matchup = { enable = true },
	})
end

function telescope()
	require("neoclip").setup({
		enable_persistent_history = true,
	})
	require("telescope").load_extension("projects")
	require("telescope").load_extension("neoclip")
	require("telescope").load_extension("fzf")
	require("telescope").setup()

	local whichkey = require("which-key")

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
			p = { "<cmd>Telescope projects theme=ivy<cr>", "Projects" },
			h = { "<cmd>Telescope oldfiles theme=ivy<cr>", "Previous Files" },
		},
	}

	whichkey.register(keymap, {
		mode = "n",
		prefix = "<leader>",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = false,
	})
end

return M

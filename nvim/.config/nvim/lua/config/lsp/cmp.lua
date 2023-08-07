local M = {}

function M.setup()
	local cmp = require("cmp")
	local lspkind = require("lspkind")

	local has_words_before = function()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

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
		-- Window Format
		-- Not file format on save!
		formatting = { format = lspkind.cmp_format({ maxwidth = 50 }) },
		mapping = cmp.mapping.preset.insert({
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end, { "i", "s" }),
		}),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "calc" },
			{ name = "path" },
			{ name = "nvim_lua" },
			{ name = "nvim_lsp_signature_help" },
		}, { { name = "buffer" } }),
	})
end

return M

return {
	"stevearc/aerial.nvim",
	event = "VeryLazy",
	opts = {
		backends = { "treesitter", "lsp" },
		update_events = { "TextChanged", "BufEnter" },
		show_guides = false,
		highlight_on_hover = true,
		highlight_closest = true,
		attach_mode = "global",
		highlight_mode = "full_width",
		autojump = true,

		layout = {
			default_direction = "float",
		},

		float = {
			border = {
				"", -- topleft
				"", -- top
				"", -- topright
				"", -- right
				"", -- bottomright
				"─", -- bottom
				"╰", -- bottomleft corner
				"│", -- left
			},
			relative = "editor",
			row = 0,
			col = 0,
			width = 40,
			height = 12,
			override = function(conf)
				local ui = vim.api.nvim_list_uis()[1]
				conf.anchor = "NE"
				conf.row = 0
				conf.col = ui.width
				return conf
			end,
		},

		post_parse_symbol = function(bufnr, item, ctx)
			-- add 2 spaces at the end of each symbol name for padding
			item.name = item.name .. "  "
			return true
		end,
	},

	config = function(_, opts)
		local aerial = require("aerial")
		aerial.setup(opts)

		-- Keymap: open float and focus
		vim.keymap.set("n", "<leader>at", function()
			aerial.open({ direction = "float" })
			vim.schedule(function()
				aerial.focus()
			end)
		end, { desc = "Open and focus Aerial outline" })

		-- Optional: map Esc or <leader>at again to go back to previous window
		vim.keymap.set("n", "<leader>at", function()
			local win = aerial.get_aerial_win()
			if win and vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_set_current_win(vim.fn.win_getid(vim.fn.winnr("#")))
			end
		end, { desc = "Return from Aerial", buffer = 0 })
	end,
}

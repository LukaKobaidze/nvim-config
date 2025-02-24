return {
	"folke/trouble.nvim",
	opts = { focus = true }, -- for default options, refer to the configuration section for custom setup.
	cmd = "Trouble",
	keys = {
		{
			"<leader>tr",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>tR",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
	},
}

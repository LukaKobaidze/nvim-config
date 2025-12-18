return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	config = function()
		require("oil").setup({
			win_options = {
				signcolumn = "yes:2",
			},
			view_options = {
				show_hidden = true,
			},
			columns = {},
		})
		vim.keymap.set("n", "-", "<cmd>Oil<CR>")
	end,
}

return {
	"nvim-treesitter/nvim-treesitter-context",
	config = function()
		require("treesitter-context").setup({
			enable = true,
		})

		vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { fg = "#A7B1BB" })
	end,
}

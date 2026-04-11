local colorValues = require("custom.color_values")

return {
	"wnkz/monoglow.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function()
		require("monoglow").setup({
			on_colors = function(colors)
				colors.glow = colorValues.primary
				colors.blue1 = "#ffffff"
				colors.blue2 = "#f1f1f1"
			end,
		})
	end,
}

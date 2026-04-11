return {
	"goolord/alpha-nvim",
	config = function()
		local startify = require("alpha.themes.startify")
		require("alpha").setup(startify.config)
	end,
}

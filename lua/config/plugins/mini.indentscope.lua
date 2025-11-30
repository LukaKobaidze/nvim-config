return {
	"nvim-mini/mini.indentscope",
	version = false,
	config = function()
		require("mini.indentscope").setup({
			symbol = "▏",
			draw = { delay = 0, animation = require("mini.indentscope").gen_animation.none() },
		})
	end,
}

return {
	"rcarriga/nvim-notify",
	config = function()
		local notify = require("notify")
		vim.notify = notify
		notify.setup({ top_down = false, max_width = 50, render = "wrapped-compact", stages = "static", fps = 60 })
		vim.keymap.set("n", "<leader>nh", ":Telescope notify<CR>", { noremap = true, silent = true })
	end,
}

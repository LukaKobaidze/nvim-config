return {
	"rcarriga/nvim-notify",
	config = function()
		local notify = require("notify")
		vim.notify = notify
		notify.setup({ top_down = false, max_width = 60, stages = "static", render = 'compact' })
		vim.keymap.set("n", "<leader>nh", ":Telescope notify<CR>", { noremap = true, silent = true })
	end,
}

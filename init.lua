require("config.lazy")
require("custom.settings")
require("custom.floaterminal")
require("custom.keymaps")
require("custom.colors")
require("custom.tgpt-chatbot")

vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
	pattern = "*", -- Apply to all buffers
	callback = function()
		vim.cmd("silent! write")
	end,
})


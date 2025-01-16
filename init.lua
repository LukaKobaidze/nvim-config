require("config.lazy")
require("custom.floaterminal")
require("custom.keymaps")
require("custom.colors")
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.termguicolors = true
vim.opt.hlsearch = false
vim.o.fillchars = "eob: "
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.pumheight = 10

vim.diagnostic.config({
	signs = false,
	virtual_text = false,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
	pattern = "*", -- Apply to all buffers
	callback = function()
		vim.cmd("silent! write")
	end,
})

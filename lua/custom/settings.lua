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

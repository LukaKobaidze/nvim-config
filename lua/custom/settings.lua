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
vim.opt.laststatus = 3
vim.opt.winborder = "double"
vim.opt.guicursor:append("c:ver25")
vim.opt.fillchars:append({
	vert = "║",
	horiz = "═",
	horizup = "╩",
	horizdown = "╦",
	vertleft = "╣",
	vertright = "╠",
	verthoriz = "╬",
})
vim.opt.guicursor = "a:block-blinkon0"

vim.diagnostic.config({
	virtual_text = false,
	float = {
		focusable = false,
		style = "minimal",
		border = "double",
		source = "always",
		header = "",
		prefix = "",
	},
})

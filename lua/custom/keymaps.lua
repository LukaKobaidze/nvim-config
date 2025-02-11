vim.keymap.set("n", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.keymap.set("v", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "r", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<leader>er",
	":lua vim.diagnostic.open_float({ focusable = true })<CR>",
	{ noremap = true, silent = true }
)
vim.keymap.set({ "n", "v" }, "<C-j>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<C-k>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "n", "nzz", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzz", { noremap = true, silent = true })
vim.keymap.set("n", "K", ":lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })

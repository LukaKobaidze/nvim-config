vim.wo.number = true
vim.wo.relativenumber = true
require("config.lazy")
require("custom.floaterminal")
vim.opt.termguicolors = true
vim.opt.hlsearch = false

vim.o.fillchars = "eob: "
vim.api.nvim_set_option('winblend', 0)
vim.api.nvim_set_option('pumblend', 0)
vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'NONE' })

vim.keymap.set("n", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("v", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "r", "<Nop>", { noremap = true, silent = true })

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
vim.api.nvim_set_keymap("n", "<leader>er", ":lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "n", "nzz", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzz", { noremap = true, silent = true })
-- Debugging: print when auto-save happens
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  pattern = "*",  -- Apply to all buffers
  callback = function()
    vim.cmd("silent! write")
  end
})

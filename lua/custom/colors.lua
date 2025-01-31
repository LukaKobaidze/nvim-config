local primary = "#c678dd"
vim.opt.termguicolors = true
vim.api.nvim_set_hl(0, "Cursor", { bg = "white", fg = "black" })
vim.api.nvim_set_option("winblend", 0)
vim.api.nvim_set_option("pumblend", 0)
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" }) -- Transparent background
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = primary }) -- Border color
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = primary })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = primary })
vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = primary, bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = "#ffffff", bg = "none" })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = primary, bg = "none" })
vim.api.nvim_set_hl(0, "FloatTitle", { fg = primary, bg = "none" })
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	primary = "rounded", -- Add rounded border
})
vim.api.nvim_set_hl(0, "WinSeparator", { fg = primary, bg = "NONE" })
vim.api.nvim_set_hl(0, "Pmenu", { fg = primary, bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpBorder", { fg = primary, bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuThumb", { bg = primary })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = primary, fg = "#000000" })
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#506477" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#ffffff" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#506477" })

vim.api.nvim_set_hl(0, "IndentLine", { fg = "#333333" })
vim.api.nvim_set_hl(0, "IndentLineCurrent", { fg = "#4e4e4e" })

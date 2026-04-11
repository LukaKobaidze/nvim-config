local colorValues = require("custom.color_values")

vim.cmd("colorscheme monoglow")

--vim.api.nvim_set_hl(0, "Keyword", { fg = colorValues.primary, bold = true })
--vim.api.nvim_set_hl(0, "@keyword", { fg = colorValues.primary, bold = true })
--vim.api.nvim_set_hl(0, "@tag.attribute", { fg = colorValues.primary, bold = true })
vim.api.nvim_set_hl(0, "Operator", { fg = colorValues.primary, bold = true })
vim.api.nvim_set_hl(0, "@operator", { fg = colorValues.primary, bold = true })
vim.api.nvim_set_hl(0, "@keyword.return", { fg = colorValues.primary, bold = true })
vim.api.nvim_set_hl(0, "@keyword.function", { fg = colorValues.primary, bold = true })
vim.api.nvim_set_hl(0, "@keyword.coroutine", { fg = colorValues.primary, bold = true })
vim.api.nvim_set_hl(0, "@keyword.type", { fg = colorValues.primary, bold = true })
vim.api.nvim_set_hl(0, "@keyword.exception", { fg = colorValues.primary, bold = true })
vim.api.nvim_set_hl(0, "@keyword.repeat", { fg = colorValues.primary, bold = true })
--vim.api.nvim_set_hl(0, "@keyword.import", { fg = colorValues.primary, bold = true })
vim.opt.termguicolors = true
vim.api.nvim_set_hl(0, "Cursor", { bg = "white", fg = "black" })
vim.api.nvim_set_option("winblend", 0)
vim.api.nvim_set_option("pumblend", 0)
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
vim.api.nvim_set_hl(0, "Comment", { fg = "#708090", bg = "none" })
vim.api.nvim_set_hl(0, "Cursor", { bg = colorValues.primary, fg = "#000000", bold = true })
vim.api.nvim_set_hl(0, "Title", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none", fg = colorValues.primary })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none", fg = colorValues.primary, bold = true })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { bg = "none", fg = colorValues.primary, bold = true })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = colorValues.primary })
vim.api.nvim_set_hl(0, "SagaBorder", { bg = "none", fg = colorValues.primary })
vim.api.nvim_set_hl(0, "NoicePopupBorder", { fg = colorValues.primary })
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = colorValues.primary })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = colorValues.primary })
vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = colorValues.primary, bg = "none", bold = true })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = colorValues.primary, bg = "none", bold = true })
vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = "#ffffff", bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = colorValues.primary, bg = "none" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = colorValues.primary, bg = "none" })
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = colorValues.primary, bg = "none", bold = true })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { fg = colorValues.primary, bg = "none", bold = true })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitleCmdline", { fg = colorValues.primary, bg = "none", bold = true })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitleHelp", { fg = colorValues.primary, bg = "none", bold = true })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitleSearch", { fg = colorValues.primary, bg = "none", bold = true })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = colorValues.primary })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderSearch", { fg = colorValues.primary })
vim.api.nvim_set_hl(0, "NoiceCmdlineIconSearch", { fg = colorValues.primary })
vim.api.nvim_set_hl(0, "FloatTitle", { fg = colorValues.primary, bg = "none", bold = true })
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = {
		{ "╔", "FloatBorder" },
		{ "═", "FloatBorder" },
		{ "╗", "FloatBorder" },
		{ "║", "FloatBorder" },
		{ "╝", "FloatBorder" },
		{ "═", "FloatBorder" },
		{ "╚", "FloatBorder" },
		{ "║", "FloatBorder" },
	},
})
vim.api.nvim_set_hl(0, "WinSeparator", { fg = colorValues.primary, bg = "NONE" })
vim.api.nvim_set_hl(0, "Pmenu", { fg = colorValues.primary, bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpBorder", { fg = colorValues.primary, bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuThumb", { bg = colorValues.primary })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = colorValues.primary, fg = "#000000" })
vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#444444", bg = "none", bold = true })
vim.api.nvim_set_hl(0, "LineNr", { fg = colorValues.primary, bg = "none", bold = true })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#444444", bg = "none", bold = true })

vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { bg = colorValues.primary, fg = "#000000" })
vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#2a2a2a" })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { fg = "#7a7a7a" })

return M

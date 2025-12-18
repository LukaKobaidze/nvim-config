vim.cmd("colorscheme monoglow")

local primary = "#9f4050"

vim.api.nvim_set_hl(0, "Keyword", { fg = primary, bold = true })
vim.api.nvim_set_hl(0, "@keyword", { fg = primary, bold = true })
vim.api.nvim_set_hl(0, "Operator", { fg = primary, bold = true })
vim.api.nvim_set_hl(0, "@operator", { fg = primary, bold = true })
vim.api.nvim_set_hl(0, "@keyword.return", { fg = primary, bold = true })
vim.api.nvim_set_hl(0, "@tag.attribute", { fg = primary, bold = true })
vim.opt.termguicolors = true
vim.api.nvim_set_hl(0, "Cursor", { bg = "white", fg = "black" })
vim.api.nvim_set_option("winblend", 0)
vim.api.nvim_set_option("pumblend", 0)
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
vim.api.nvim_set_hl(0, "Comment", { fg = "#708090", bg = "none" })
vim.api.nvim_set_hl(0, "Cursor", { bg = primary, fg = "#000000", bold = true })
vim.api.nvim_set_hl(0, "Title", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none", fg = primary })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none", fg = primary, bold = true })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { bg = "none", fg = primary, bold = true })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = primary })
vim.api.nvim_set_hl(0, "SagaBorder", { bg = "none", fg = primary })
vim.api.nvim_set_hl(0, "NoicePopupBorder", { fg = primary })
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = primary })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = primary })
vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = primary, bg = "none", bold = true })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = primary, bg = "none", bold = true })
vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = "#ffffff", bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = primary, bg = "none" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = primary, bg = "none" })
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = primary, bg = "none", bold = true })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { fg = primary, bg = "none", bold = true })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitleCmdline", { fg = primary, bg = "none", bold = true })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitleHelp", { fg = primary, bg = "none", bold = true })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitleSearch", { fg = primary, bg = "none", bold = true })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = primary })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderSearch", { fg = primary })
vim.api.nvim_set_hl(0, "NoiceCmdlineIconSearch", { fg = primary })
vim.api.nvim_set_hl(0, "FloatTitle", { fg = primary, bg = "none", bold = true })
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
vim.api.nvim_set_hl(0, "WinSeparator", { fg = primary, bg = "NONE" })
vim.api.nvim_set_hl(0, "Pmenu", { fg = primary, bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpBorder", { fg = primary, bg = "NONE" })
vim.api.nvim_set_hl(0, "PmenuThumb", { bg = primary })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = primary, fg = "#000000" })
vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#444444", bg = "none", bold = true })
vim.api.nvim_set_hl(0, "LineNr", { fg = primary, bg = "none", bold = true })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#444444", bg = "none", bold = true })

vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { bg = primary, fg = "#000000" })
vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#2a2a2a" })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { fg = "#7a7a7a" })

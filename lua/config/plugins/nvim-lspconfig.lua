return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local capabilities = cmp_nvim_lsp.default_capabilities()

		lspconfig.ts_ls.setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				vim.diagnostic.open_float()
			end,
		})
	end,
}

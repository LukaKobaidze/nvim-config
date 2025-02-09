return {
	"jose-elias-alvarez/null-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.diagnostics.eslint.with({
					command = "eslint_d", -- Optional: use eslint_d for faster linting
				}),
				null_ls.builtins.formatting.prettier.with({
					filetypes = {
						"css",
						"sass",
						"scss",
						"javascript",
						"typescript",
						"css",
						"html",
						"javascriptreact",
						"typescriptreact",
					},
				}),
				null_ls.builtins.formatting.stylua.with({
					command = "/home/luka/.cargo/bin/stylua",
				}),
			},
		})
		vim.api.nvim_set_keymap(
			"n",
			"<leader>fr",
			":lua vim.lsp.buf.format({ async = true })<CR>",
			{ noremap = true, silent = true }
		)
	end,
}

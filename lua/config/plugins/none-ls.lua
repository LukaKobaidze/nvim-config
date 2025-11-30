return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},

	config = function()
		local null_ls = require("null-ls")
		local sources = {}

		table.insert(sources, null_ls.builtins.formatting.prettier)

		table.insert(sources, null_ls.builtins.formatting.stylua)

		if vim.fn.executable("eslint_d") == 1 then
			table.insert(sources, null_ls.builtins.diagnostics.eslint_d)
		end

		table.insert(sources, require("none-ls.code_actions.eslint"))

		null_ls.setup({
			sources = sources,
		})

		vim.keymap.set("n", "<leader>fr", function()
			vim.lsp.buf.format({ async = true })
		end)
	end,
}

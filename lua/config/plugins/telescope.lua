return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "TelescopeResults",
			callback = function(ctx)
				vim.api.nvim_buf_call(ctx.buf, function()
					vim.fn.matchadd("TelescopeParent", "\t\t.*$")
					vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
				end)
			end,
		})

		require("telescope").setup({
			defaults = {
				path_display = function(_, path)
					local tail = vim.fs.basename(path)
					local parent = vim.fs.dirname(path)
					if parent == "." then
						return tail
					end
					return string.format("%s\t\t%s", tail, parent)
				end,
			},
			pickers = {
				find_files = {
					theme = "dropdown",
					find_command = { "rg", "--files", "--sortr=modified" },
				},
				live_grep = {
					theme = "dropdown",
				},
			},
			extensions = {
				fzf = {},
			},
		})
		require("telescope").load_extension("fzf")

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>fd", builtin.find_files, { desc = "Telescope find files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
		vim.keymap.set("n", "<leader>fc", function()
			builtin.find_files({
				cwd = vim.fn.stdpath("config"),
			})
		end)
		vim.keymap.set("n", "<leader>fo", function()
			builtin.find_files({ cwd = "~/Documents/obsidian-notes/daily-notes" })
		end)
	end,
}

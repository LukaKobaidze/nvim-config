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

		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")
		local themes = require("telescope.themes")

		telescope.setup({
			defaults = {
				color_devicons = false,
				prompt_prefix = " > ",
				selection_caret = " > ",
				entry_prefix = "   ",

				border = {
					prompt = { 1, 1, 1, 1 },
					results = { 1, 1, 1, 1 },
					preview = { 1, 1, 1, 1 },
				},

				borderchars = {
					prompt = {
						" ", -- top
						" ", -- right
						"═", -- bottom
						"║", -- left
						"║", -- top_left (connecting side)
						" ", -- top_right
						"═", -- bottom_right
						"╚", -- bottom_left
					},

					results = {
						"═", -- top
						" ", -- right
						" ", -- bottom
						"║", -- left
						"╔", -- top_left
						"═", -- top_right
						" ", -- bottom_right
						"║", -- bottom_left (connecting side)
					},

					preview = {
						"═", -- top
						"║", -- right
						"═", -- bottom
						"║", -- left
						"╦", -- top_left (double tee)
						"╗", -- top_right
						"╝", -- bottom_right
						"╩", -- bottom_left
					},
				},
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
				live_grep = { theme = "ivy" },
			},
			extensions = { fzf = {} },
		})
		telescope.load_extension("fzf")

		local function find_files_dropdown(opts)
			opts = opts or {}
			opts = vim.tbl_deep_extend(
				"force",
				opts,
				themes.get_dropdown({
					disable_devicons = true,

					border = {
						prompt = { 1, 1, 1, 1 },
						results = { 1, 1, 1, 1 },
					},

					borderchars = {
						prompt = {
							"═", -- top
							"║", -- right
							"═", -- bottom
							"║", -- left
							"╔", -- top_left
							"╗", -- top_right
							"║", -- bottom_right  (straight, no corner)
							"║", -- bottom_left   (straight, no corner)
						},

						results = {
							"═", -- top            (straight continuation)
							"║", -- right
							"═", -- bottom
							"║", -- left
							"║", -- top_left       (NO corner)
							"║", -- top_right      (NO corner)
							"╝", -- bottom_right
							"╚", -- bottom_left
						},
					},

					layout_config = {
						width = 0.5,
						height = 0.5,
					},
					previewer = false,
					find_command = { "rg", "--files", "--sortr=modified" },
					sorting_strategy = "ascending", -- shows recent first
					show_line = false,
					show_column = false,
				})
			)
			builtin.find_files(opts)
		end

		vim.keymap.set("n", "<leader>fd", function()
			find_files_dropdown({ prompt_title = "FIND FILES" })
		end, { desc = "Telescope find files" })

		vim.keymap.set("n", "<leader>fe", function()
			local directory = vim.fn.expand("%:p:h")
			if directory:match("^oil://") then
				directory = directory:gsub("^oil://", "")
			end
			local last_part = vim.fn.fnamemodify(directory, ":t")
			find_files_dropdown({
				cwd = directory,
				prompt_title = "FIND FILES (" .. string.upper(last_part) .. ")",
			})
		end, { desc = "Telescope find files" })

		vim.keymap.set("n", "<leader>fc", function()
			find_files_dropdown({
				cwd = vim.fn.stdpath("config"),
				prompt_title = "FIND FILES (NEOVIM CONFIG)",
			})
		end)

		vim.keymap.set("n", "<leader>fo", function()
			find_files_dropdown({
				cwd = "~/Documents/obsidian-notes/daily-notes",
				prompt_title = "FIND FILES (OBSIDIAN)",
			})
		end)

		vim.keymap.set("n", "<leader>fg", function()
			builtin.live_grep({
				prompt_title = "LIVE GREP",
				results_title = false,
				preview_title = "PREVIEW",

				border = {
					prompt = { 1, 1, 1, 1 },
					preview = { 1, 1, 1, 1 },
					results = { 1, 1, 1, 1 },
				},

				borderchars = {
					prompt = {
						"═", -- top
						" ", -- right
						" ", -- bottom
						" ", -- left
						"═", -- top_left
						"═", -- top_right
						" ", -- bottom_right
						" ", -- bottom_left
					},

					results = {
						" ", -- top
						" ", -- right
						" ", -- bottom
						" ", -- left
						" ", -- top_left
						" ", -- top_right
						" ", -- bottom_right
						" ", -- bottom_left
					},

					preview = {
						"═", -- top
						"║", -- right
						"═", -- bottom
						"║", -- left
						"╔", -- top_left
						"╗", -- top_right
						"╝", -- bottom_right
						"╚", -- bottom_left
					},
				},
			})
		end, { desc = "Telescope live grep" })
	end,
}

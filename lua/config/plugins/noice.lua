return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		views = {
			popup = {
				border = {
					style = "double",
				},
			},
			cmdline_popup = {
				border = {
					style = "double",
				},
			},
		},
		cmdline = {
			format = {
				cmdline = {
					icon = ">",
					title = " CMDLINE ",
				},
				search_down = { icon = "/", title = " SEARCH DOWN " },
				search_up = { icon = "/", title = " SEARCH UP " },
				help = {
					icon = "?",
					title = " HELP ",
				},
			},
		},
		messages = {
			view = "mini",
			view_error = "mini",
			view_warn = "mini",
		},
		notify = {
			view = "mini",
		},
		popupmenu = {
			enabled = false,
		},
		lsp = {
			hover = {
				enabled = false,
			},
			signature = {
				enabled = false,
			},
		},
		presents = {
			lsp_doc_border = false,
		},
	},
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
}

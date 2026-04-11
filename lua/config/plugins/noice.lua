return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		cmdline = {
			format = {
				cmdline = {
					icon = ">",
					title = " cmdline ",
				},
				search_down = { icon = "/", title = " search down " },
				search_up = { icon = "/", title = " search up " },
				help = {
					icon = "?",
					title = " help ",
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

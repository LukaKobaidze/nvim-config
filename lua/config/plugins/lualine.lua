local colorValues = require("custom.color_values")

local colors = {
	bg = "#000000",
	fg = "#cccccc",
	fg_dim = "#7a7a7a",
	fg_muted = "#555555",
	accent = colorValues.primary,
}

local is_current_file_in_cwd = function()
	local cwd = vim.fn.getcwd()
	local file_path = vim.fn.expand("%:p")

	if file_path:match("^oil://") then
		file_path = file_path:gsub("^oil://", "")
	end

	cwd = cwd:gsub("/$", "") .. "/"
	file_path = file_path:gsub("/$", "") .. "/"

	return file_path:sub(1, #cwd) == cwd
end

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

local config = {
	options = {
		component_separators = "",
		section_separators = "",
		theme = {
			normal = { c = { fg = colors.fg } },
			inactive = { c = { fg = colors.fg } },
		},
		globalstatus = true,
	},
	sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

ins_left({
	function()
		local m = require("lualine.components.mode")()
		return m
	end,
	color = function()
		return { bg = colors.accent, fg = colors.bg, gui = "bold" }
	end,
	padding = 2,
})

ins_left({
	function()
		return " "
	end,
	padding = { left = 0, right = 0 },
})

ins_left({
	function()
		return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
	end,
	cond = function()
		return is_current_file_in_cwd() and vim.o.columns > 90
	end,
	padding = { left = 0, right = 0 },
})

ins_left({
	function()
		return "/"
	end,
	padding = { left = 0, right = 0 },
	color = { fg = colors.fg_dim },
	cond = function()
		return is_current_file_in_cwd() and vim.o.columns > 90
	end,
})

ins_left({
	function()
		local max_length = math.floor(vim.o.columns * 0.3)
		local cwd_dir = vim.fn.fnamemodify(vim.fn.expand("%:h"), ":.")

		if cwd_dir:match("^oil://") then
			cwd_dir = cwd_dir:gsub("^oil://", "")
			cwd_dir = cwd_dir:gsub("^" .. vim.pesc(vim.fn.getcwd()) .. "/", "")
		end

		if cwd_dir == vim.fn.getcwd() then
			return ""
		end

		if cwd_dir:match("^/") then
			cwd_dir = cwd_dir:sub(2)
		end

		local dirs = vim.split(cwd_dir, "/", { trimempty = true })

		if #cwd_dir > max_length then
			while #cwd_dir > max_length and #dirs > 1 do
				table.remove(dirs, 1)
				cwd_dir = ".../" .. table.concat(dirs, "/")
			end
		end

		if cwd_dir ~= "" then
			cwd_dir = cwd_dir .. "/"
		end

		return cwd_dir
	end,
	color = { fg = colors.fg_dim },
	padding = { left = 0, right = 0 },
	cond = function()
		return vim.o.columns > 90
	end,
})

ins_left({
	function()
		local filename

		filename = vim.fn.expand("%:t")
		if filename == nil or filename == "" then
			filename = vim.bo.filetype
		end

		return filename
	end,
	padding = { left = 0, right = 1 },
})

ins_left({
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", info = " " },
	diagnostics_color = {
		error = { fg = colors.accent },
		warn = { fg = colors.fg_dim },
		info = { fg = colors.fg_muted },
	},
})

-- Mid section
ins_left({
	function()
		return "%="
	end,
})

-- Right section

ins_right({
	function()
		return " "
	end,
	padding = { left = 0, right = 0 },
})

ins_right({
	"diff",
	symbols = { added = "󰐖 ", modified = "󰦓 ", removed = "󰍵 " },
	diff_color = {
		added = { fg = colors.fg },
		modified = { fg = colors.fg_dim },
		removed = { fg = colors.accent },
	},
	cond = conditions.hide_in_width,
	padding = 1,
})

ins_right({
	function()
		local branch = vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.head
		if not branch or branch == "" then
			return ""
		end
		return "[" .. string.upper(branch) .. "]"
	end,
	color = function()
		return { gui = "bold" }
	end,
	padding = { left = 1, right = 2 },
})

ins_right({
	function()
		return string.format("%d / %d", vim.fn.line("."), vim.fn.line("$"))
	end,
	color = { bg = colors.accent, fg = colors.bg, gui = "bold" },
	padding = { left = 2, right = 2 },
})

return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup(config)
	end,
}

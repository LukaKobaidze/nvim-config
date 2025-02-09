local colors = {
	bg = "",
	fg = "#cfbbbd",
	fglow = "#9f8c8e",
	yellow = "#ECBE7B",
	cyan = "#008080",
	darkblue = "#081633",
	green = "#98be65",
	orange = "#FF8800",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	blue = "#51afef",
	red = "#ec5f67",
}

local mode_color = function()
	local colors = {
		n = colors.red,
		i = colors.blue,
		v = colors.green,
		[""] = colors.green,
		V = colors.green,
		c = colors.magenta,
		no = colors.red,
		s = colors.orange,
		S = colors.orange,
		[""] = colors.orange,
		ic = colors.yellow,
		R = colors.violet,
		Rv = colors.violet,
		cv = colors.red,
		ce = colors.red,
		r = colors.cyan,
		rm = colors.cyan,
		["r?"] = colors.cyan,
		["!"] = colors.red,
		t = colors.red,
	}

	return colors[vim.fn.mode()]
end

local is_current_file_in_cwd = function()
	local cwd = vim.fn.getcwd() -- Get the current working directory
	local file_path = vim.fn.expand("%:p") -- Get the full absolute path of the current file

	-- Ensure both paths end with a slash for accurate comparison
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

-- Config
local config = {
	options = {
		-- Disable sections and component separators
		component_separators = "",
		section_separators = "",
		theme = {
			-- We are going to use lualine_c an lualine_x as left and
			-- right section. Both are highlighted by c theme .  So we
			-- are just setting default looks o statusline
			normal = { c = { fg = colors.fg, bg = colors.bg } },
			inactive = { c = { fg = colors.fg, bg = colors.bg } },
		},
		globalstatus = true,
	},
	sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		-- These will be filled later
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

ins_left({
	function()
		return vim.fn.mode()
	end,
	color = function()
		return { bg = mode_color(), fg = "#000000", gui = "bold" }
	end,
	padding = { left = 1, right = 1 },
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
	cond = is_current_file_in_cwd,
	padding = { left = 0, right = 0 },
	color = { gui = "bold" },
})

ins_left({
	function()
		return "/"
	end,
	padding = { left = 0, right = 0 },
	color = { fg = colors.fglow },
	cond = is_current_file_in_cwd,
})

ins_left({
	function()
		local max_length = math.floor(vim.o.columns * 0.3)
		local cwd_dir = vim.fn.fnamemodify(vim.fn.expand("%:h"), ":.")

		if cwd_dir:match("^/") then
			cwd_dir = cwd_dir:sub(2)
		end

		if #cwd_dir > max_length then
			cwd_dir = "<" .. cwd_dir:sub(-max_length + 1)
		end

		return cwd_dir .. "/"
	end,
	color = { fg = colors.fglow },
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
	color = { gui = "bold" },
	padding = { left = 0 },
})

ins_left({
	function()
		local devicons = require("nvim-web-devicons")
		local icon = devicons.get_icon(vim.fn.expand("%:t")) or devicons.get_icon_by_filetype(vim.bo.filetype) or ""

		return icon
	end,
	color = function()
		local filename = vim.fn.expand("%:t")
		local _, color = require("nvim-web-devicons").get_icon_color(filename)

		return { fg = color }
	end,
})

ins_left({ "location" })
ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })

ins_left({
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", info = " " },
	diagnostics_color = {
		error = { fg = colors.red },
		warn = { fg = colors.yellow },
		info = { fg = colors.cyan },
	},
})

-- Insert mid section.
ins_left({
	function()
		return "%="
	end,
})

-- Add components to right sections

ins_right({
	"filesize",
	padding = { right = 2 },
	cond = function()
		return vim.o.columns > 90
	end,
})

ins_right({
	"o:encoding", -- option component same as &encoding in viml
	fmt = string.upper, -- I'm not sure why it's upper case either ;)
	color = { gui = "bold" },
	padding = { right = 2 },
	cond = function()
		return vim.o.columns > 90
	end,
})

ins_right({
	"diff",
	symbols = { added = "󰐖 ", modified = "󰦓 ", removed = "󰍵 " },
	diff_color = {
		added = { fg = colors.green },
		modified = { fg = colors.orange },
		removed = { fg = colors.red },
	},
	cond = conditions.hide_in_width,
	padding = { left = 0, right = 2 },
})

ins_right({
	function()
		local branch = vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.head

		if not branch or branch == "" then
			return ""
		end

		return branch .. " "
	end,
	color = function()
		return { bg = mode_color(), fg = "#000000", gui = "bold" }
	end,
	padding = { left = 1, right = 1 },
})

local is_branch = function()
	local branch = vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.head

	if branch then
		return false
	end
	return true
end

ins_right({
	"fileformat",
	fmt = string.upper,
	icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
	cond = is_branch,
	color = { fg = colors.green, gui = "bold" },
})

ins_right({
	function()
		return "▊"
	end,
	cond = is_branch,
	color = function()
		return { fg = mode_color() }
	end,
	padding = { left = 1 },
})

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup(config)
	end,
}

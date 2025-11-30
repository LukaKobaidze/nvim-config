local colors = {
	bg = "none",
	fg = "#BBAAE5", -- glow-ish purple
	fglow = "#8A79B0", -- glow-ish purple

	yellow = "#F2D48F", -- warm gold
	cyan = "#8BE9FD", -- soft neon aqua
	violet = "#CBA5FF", -- dreamy violet
	magenta = "#FF9AD5", -- pink-magenta neon
	blue = "#8AA8FF", -- purple-blue glow
	gray = "#9FA4C1", -- soft steel purple-gray

	warning = "#F3C984",
	error = "#F28BAA",
}

local mode_color = function()
	local mode = vim.fn.mode()

	-- Soft ambience-purple palette
	local map = {
		n = "#9F93D1", -- normal: soft cozy purple
		no = "#9F93D1",

		i = "#75BFD7", -- insert: gentle aqua-lavender
		ic = "#75BFD7",

		v = "#BCA7E8", -- visual: muted lilac glow
		V = "#BCA7E8",
		[""] = "#BCA7E8",

		c = "#D7CBA7", -- command: soft warm beige-purple
		ce = "#D7CBA7",

		R = "#DFA0C4", -- replace: soft pink-mauve
		Rv = "#DFA0C4",
		r = "#DFA0C4",
		rm = "#DFA0C4",
		["r?"] = "#DFA0C4",

		t = "#8793C6", -- terminal: soft lavender-blue
		["!"] = "#8793C6",
	}

	return map[mode] or "#9F93D1" -- fallback: normal mode
end

local is_current_file_in_cwd = function()
	local cwd = vim.fn.getcwd() -- Get the current working directory
	local file_path = vim.fn.expand("%:p") -- Get the full absolute path of the current file

	if file_path:match("^oil://") then
		file_path = file_path:gsub("^oil://", "")
	end

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
			normal = { c = { fg = colors.fg } },
			inactive = { c = { fg = colors.fg } },
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
		local m = require("lualine.components.mode")()
		return string.lower(m)
	end,
	separator = { right = "" },
	color = function()
		return { bg = mode_color(), fg = "#000000", gui = "bold" }
	end,
	padding = { left = 2, right = 1 },
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

		-- Check if shortening is needed
		if #cwd_dir > max_length then
			while #cwd_dir > max_length and #dirs > 1 do
				table.remove(dirs, 1) -- Remove the first directory
				cwd_dir = ".../" .. table.concat(dirs, "/")
			end
		end

		if cwd_dir ~= "" then
			cwd_dir = cwd_dir .. "/"
		end

		return cwd_dir
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
	padding = 0,
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
	padding = { left = 1, right = 2 },
})

ins_left({ "location" })
ins_left({ "progress", color = { gui = "bold" } })

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
	function()
		return " "
	end,
	padding = { left = 0, right = 0 },
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
		return " " .. branch
	end,
	separator = { left = "" },
	color = function()
		return { bg = mode_color(), fg = "#000000", gui = "bold" }
	end,
	padding = { left = 1, right = 2 },
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
		return "█"
	end,
	cond = is_branch,
	color = function()
		return { fg = mode_color() }
	end,
	padding = { left = 1, right = 0 },
})

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup(config)
	end,
}

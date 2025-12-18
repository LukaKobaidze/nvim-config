local state = {
	floating = {
		buf = -1,
		win = -1,
	},
}

local function create_floating_window(opts)
	opts = opts or {}
	local width = opts.width or math.floor(vim.o.columns * 0.8)
	local height = opts.height or math.floor(vim.o.lines * 0.8)

	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	local buf = nil
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true)
	end

	local win_config = {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		border = "double",
		title = " TERMINAL ",
		title_pos = "center",
	}

	local win = vim.api.nvim_open_win(buf, true, win_config)
	vim.cmd([[highlight MyFloat guibg=NONE]])
	vim.cmd([[highlight link MyFloatBorder TelescopeBorder]])
	vim.api.nvim_win_set_option(win, "winhl", "Normal:MyFloat,FloatBorder:MyFloatBorder")

	return { buf = buf, win = win }
end

local toggle_terminal = function()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = create_floating_window({ buf = state.floating.buf })
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal()

			local terminal_job_id = vim.b.terminal_job_id
			local command = "tmux a\n"
			vim.api.nvim_chan_send(terminal_job_id, command)
		end
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
	if vim.api.nvim_win_is_valid(state.floating.win) then
		vim.cmd("startinsert")
	end
end

vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})

vim.keymap.set("n", "<leader>te", toggle_terminal)

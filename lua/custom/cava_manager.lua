local M = {}
local uv = vim.loop

local cava_handle = nil
local fifo_path = "/tmp/cava.fifo"

-- Run shell command (non-blocking)
local function sh(cmd)
	os.execute(cmd)
end

function M.start()
	-- Clean FIFO first
	sh("rm -f " .. fifo_path)
	sh("mkfifo " .. fifo_path)

	-- Spawn cava without attaching to terminal
	cava_handle = uv.spawn("cava", {
		stdio = { nil, nil, nil },
	}, function(_, _)
		cava_handle = nil
	end)
end

function M.stop()
	-- kill cava if running
	if cava_handle then
		uv.process_kill(cava_handle, "sigterm")
		cava_handle = nil
	end

	-- remove FIFO
	sh("rm -f " .. fifo_path)
end

return M

hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@60",
	position = "0x0",
	scale = "1",
})

hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@60",
	position = "0x-1080",
	scale = "1",
})

-- iPad Mini (2048x1536)
-- hl.monitor({ output = "virtual", mode = "2048x1536@60", position = "-2048x0", scale = "1" })

for workspace = 1, 10 do
	hl.workspace_rule({
		workspace = tostring(workspace),
		monitor = "eDP-1",
	})
end

for workspace = 11, 20 do
	local monitor = "HDMI-A-1" or "virtual" or "eDP-1"
	hl.workspace_rule({
		workspace = tostring(workspace),
		monitor = monitor,
	})
end

-- Physical Monitors
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

hl.monitor({
	output = "DP-2",
	mode = "1920x1080@60",
	position = "0x-1080",
	scale = "1",
})

-- Assign Workspaces 1-10 to Built-in Display
for workspace = 1, 10 do
	hl.workspace_rule({
		workspace = tostring(workspace),
		monitor = "eDP-1",
	})
end

-- Workspaces 11-20 for external/virtual displays
local secondary_monitors = { "HDMI-A-1", "DP-2", "moonlight" }

for workspace = 11, 20 do
	for _, mon in ipairs(secondary_monitors) do
		hl.workspace_rule({
			workspace = tostring(workspace),
			monitor = mon,
		})
	end
end

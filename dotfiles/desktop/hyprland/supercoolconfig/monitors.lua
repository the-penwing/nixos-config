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

-- iPhone XS Max (HEADLESS-1)
hl.monitor({
	output = "virtual",
	mode = "2688x1242@60",
	position = "-2688x0",
	scale = "1",
})

-- iPad Mini (HEADLESS-2)
hl.monitor({
	output = "virtual",
	mode = "2048x1536@60",
	position = "-2048x0",
	scale = "1",
})

-- Assign Workspaces 1-10 to Built-in Display
for workspace = 1, 10 do
	hl.workspace_rule({
		workspace = tostring(workspace),
		monitor = "eDP-1",
	})
end

-- Fallback loop for Workspaces 11-20 based on connected outputs
local secondary_monitors = { "HDMI-A-1", "DP-2", "virtual", "eDP-1" }

for workspace = 11, 20 do
	for _, mon in ipairs(secondary_monitors) do
		hl.workspace_rule({
			workspace = tostring(workspace),
			monitor = mon,
		})
	end
end

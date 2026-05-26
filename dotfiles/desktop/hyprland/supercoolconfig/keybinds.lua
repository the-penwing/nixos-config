local mainMod = "SUPER"

local terminal = "ghostty"
local fileManager = "thunar"
local browser = "qutebrowser"
local launcher = "caelestia shell drawers toggle launcher"
local lockscreen = "caelestia shell lock lock"

local function bind(mods, key, dispatcher, opts)
	if mods == "" then
		hl.bind(key, dispatcher, opts)
		return
	end

	hl.bind(mods .. " + " .. key, dispatcher, opts)
end

local core_binds = {
	{ mods = mainMod, key = "Return", dispatcher = hl.dsp.exec_cmd(terminal) },
	{ mods = mainMod, key = "B", dispatcher = hl.dsp.exec_cmd(browser) },
	{ mods = mainMod, key = "E", dispatcher = hl.dsp.exec_cmd(fileManager) },
	{ mods = mainMod, key = "N", dispatcher = hl.dsp.exec_cmd("obsidian") },
	{ mods = mainMod, key = "M", dispatcher = hl.dsp.exec_cmd(terminal) },
	{ mods = mainMod, key = "R", dispatcher = hl.dsp.exec_cmd(launcher) },
	{ mods = mainMod, key = "Q", dispatcher = hl.dsp.window.close() },
	{ mods = mainMod .. " + SHIFT", key = "Q", dispatcher = hl.dsp.exit() },
	{
		mods = mainMod,
		key = "F",
		dispatcher = hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
	},
	{
		mods = mainMod .. " + SHIFT",
		key = "F",
		dispatcher = hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }),
	},
	{ mods = mainMod, key = "V", dispatcher = hl.dsp.window.float({ action = "toggle" }) },
	{ mods = "ALT", key = "L", dispatcher = hl.dsp.exec_cmd(lockscreen) },
}

for _, item in ipairs(core_binds) do
	bind(item.mods, item.key, item.dispatcher, item.opts)
end

local screenshot_binds = {
	{ mods = "", key = "Print", dispatcher = hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy') },
	{
		mods = "SHIFT",
		key = "Print",
		dispatcher = hl.dsp.exec_cmd("grim ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png"),
	},
	{
		mods = mainMod,
		key = "Print",
		dispatcher = hl.dsp.exec_cmd('grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png'),
	},
}

for _, item in ipairs(screenshot_binds) do
	bind(item.mods, item.key, item.dispatcher)
end

local media_binds = {
	{ key = "XF86AudioRaiseVolume", dispatcher = hl.dsp.exec_cmd("pamixer -i 5"), repeating = true },
	{ key = "XF86AudioLowerVolume", dispatcher = hl.dsp.exec_cmd("pamixer -d 5"), repeating = true },
	{ key = "XF86AudioMute", dispatcher = hl.dsp.exec_cmd("pamixer -t"), repeating = true },
	{ key = "XF86MonBrightnessUp", dispatcher = hl.dsp.global("caelestia:brightnessUp"), repeating = true },
	{ key = "XF86MonBrightnessDown", dispatcher = hl.dsp.global("caelestia:brightnessDown"), repeating = true },
	{ key = "XF86AudioPlay", dispatcher = hl.dsp.exec_cmd("playerctl play-pause") },
	{ key = "XF86AudioNext", dispatcher = hl.dsp.exec_cmd("playerctl next") },
	{ key = "XF86AudioPrev", dispatcher = hl.dsp.exec_cmd("playerctl previous") },
}

for _, item in ipairs(media_binds) do
	bind("", item.key, item.dispatcher, { locked = true, repeating = item.repeating == true })
end

local focus_directions = {
	left = "left",
	right = "right",
	up = "up",
	down = "down",
}

for key, direction in pairs(focus_directions) do
	bind(mainMod, key, hl.dsp.focus({ direction = direction }))
end

local move_directions = {
	H = "l",
	J = "d",
	K = "u",
	L = "r",
	left = "l",
	right = "r",
	up = "u",
	down = "d",
}

for key, direction in pairs(move_directions) do
	local direction_name = direction
	if direction == "l" then
		direction_name = "left"
	elseif direction == "r" then
		direction_name = "right"
	elseif direction == "u" then
		direction_name = "up"
	elseif direction == "d" then
		direction_name = "down"
	end

	bind(mainMod .. " + SHIFT", key, hl.dsp.window.move({ direction = direction_name }))
end

for key, delta in pairs(move_directions) do
	local x = 0
	local y = 0

	if delta == "l" then
		x = -40
	elseif delta == "r" then
		x = 40
	elseif delta == "u" then
		y = -40
	else
		y = 40
	end

	bind(mainMod .. " + ALT", key, hl.dsp.window.resize({ x = x, y = y, relative = true }), { repeating = true })
end

for i = 1, 10 do
	local key = tostring(i % 10)
	local workspace = tostring(i)
	bind(mainMod, key, hl.dsp.focus({ workspace = workspace }))
	bind(mainMod .. " + SHIFT", key, hl.dsp.window.move({ workspace = workspace }))
end
for i = 11, 20 do
	local key = tostring(i % 10)
	local workspace = tostring(i)
	bind(mainMod .. " + CTRL + ", key, hl.dsp.focus({ workspace = workspace }))
	bind(mainMod .. " + CTRL + SHIFT", key, hl.dsp.window.move({ workspace = workspace }))
end

bind(mainMod, "mouse_down", hl.dsp.focus({ workspace = "e+1" }))
bind(mainMod, "mouse_up", hl.dsp.focus({ workspace = "e-1" }))
bind(mainMod, "S", hl.dsp.workspace.toggle_special("magic"))
bind(mainMod .. " + SHIFT", "S", hl.dsp.window.move({ workspace = "special:magic" }))
bind(mainMod, "mouse:272", hl.dsp.window.drag(), { mouse = true })
bind(mainMod, "mouse:273", hl.dsp.window.resize(), { mouse = true })

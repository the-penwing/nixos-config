local mod = "SUPER"

-- Colours
local primary = "BD93F9"
local secondary = "50FA7B"
local inactive = "44475A"

-- Monitors
hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "0x0", scale = "1" })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "0x-1080", scale = "1" })
hl.monitor({ output = "DP-2", mode = "1920x1080@60", position = "0x-1080", scale = "1" })

for i = 1, 10 do
	hl.workspace_rule({ workspace = tostring(i), monitor = "eDP-1" })
end

-- Environment
hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("QS_ICON_THEME", "Dracula")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- Autostart
hl.on("hyprland.start", function()
	hl.exec_cmd("udiskie")
	hl.exec_cmd("elephant")
	hl.exec_cmd("walker --gapplication-service")
	hl.exec_cmd("hyprpolkitagent")
	hl.exec_cmd("wl-paste --watch cliphist store")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("systemctl --user start hyprland-session.target")
	hl.exec_cmd("swaync")
	hl.exec_cmd("kando")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("WGPU_BACKEND=gl ashell")
	hl.exec_cmd("hyprswitch init --show-title &")
end)

-- Input
hl.config({
	input = {
		kb_layout = "au",
		kb_options = "compose:ralt",
		follow_mouse = 1,
		sensitivity = 0.15,
		accel_profile = "flat",
		touchpad = {
			natural_scroll = true,
			tap_to_click = true,
			tap_and_drag = true,
			drag_lock = 0,
			scroll_factor = 1.2,
		},
	},
})

hl.gesture({ fingers = 3, direction = "vertical", action = "workspace" })

-- Look and feel
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 2,
		col = {
			active_border = {
				colors = { "rgba(" .. primary .. "ff)", "rgba(" .. secondary .. "ff)" },
				angle = 45,
			},
			inactive_border = "rgba(" .. inactive .. "ff)",
		},
		resize_on_border = true,
		allow_tearing = false,
		layout = "dwindle",
	},
	decoration = {
		rounding = 12,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = {
			enabled = true,
			range = 12,
			render_power = 2,
			color = "rgba(1d2021cc)",
			color_inactive = "rgba(1d202188)",
		},
		blur = { enabled = true, size = 6, passes = 2, vibrancy = 0.1696, special = true },
	},
	animations = { enabled = true },
	master = { new_status = "master" },
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		mouse_move_enables_dpms = true,
		key_press_enables_dpms = true,
		focus_on_activate = true,
		animate_manual_resizes = true,
		animate_mouse_windowdragging = true,
		enable_swallow = true,
		swallow_regex = "^(ghostty|foot|Alacritty)$",
	},
	cursor = { no_hardware_cursors = 0, enable_hyprcursor = true },
	xwayland = { force_zero_scaling = true },
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.35, 0.95 } } })
hl.curve("snappyBounce", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "snappyBounce", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "easeInOutCubic" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "linear" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "linear", style = "loop" })
hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "easeOutQuint" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "easeOutQuint", style = "slidevert" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 5, bezier = "snappyBounce", style = "slidevert" })

-- Apps
hl.bind(mod .. " + Return", hl.dsp.exec_cmd("ghostty"))
hl.bind(mod .. " + M", hl.dsp.exec_cmd("ghostty"))
hl.bind(mod .. " + B", hl.dsp.exec_cmd("firefox"))
hl.bind(mod .. " + E", hl.dsp.exec_cmd("thunar"))
hl.bind(mod .. " + D", hl.dsp.exec_cmd("zeal"))
hl.bind(mod .. " + N", hl.dsp.exec_cmd("swaync-client -t"))
hl.bind(mod .. " + SHIFT + N", hl.dsp.exec_cmd("obsidian"))
hl.bind(mod .. " + R", hl.dsp.exec_cmd("nc -U /run/user/1000/walker/walker.sock"))
hl.bind(mod .. " + CTRL + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind("CTRL + Space", hl.dsp.exec_cmd('kando -m "Main Menu"'))

-- Clipboard and emoji
hl.bind(mod .. " + V", hl.dsp.exec_cmd("cliphist list | walker -d | cliphist decode | wl-copy"))
hl.bind(mod .. " + ALT + V", hl.dsp.exec_cmd("cliphist delete-query"))
hl.bind(mod .. " + Period", hl.dsp.exec_cmd("bemoji -n"))

-- Screenshots
hl.bind(mod .. " + Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))
hl.bind(
	mod .. " + SHIFT + Print",
	hl.dsp.exec_cmd('grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png')
)

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Window management
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + SHIFT + Q", hl.dsp.exit())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mod .. " + SHIFT + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + P", hl.dsp.window.pin({ action = "toggle" }))
hl.bind("ALT + Tab", hl.dsp.window.cycle_next())
hl.bind("ALT + SHIFT + Tab", hl.dsp.window.cycle_next({ next = false }))

-- Focus
hl.bind(mod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Move window (SUPER+SHIFT, vim keys or arrows)
hl.bind(mod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

-- Resize window (SUPER+ALT, vim keys or arrows)
hl.bind(mod .. " + ALT + H", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
hl.bind(mod .. " + ALT + J", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true })
hl.bind(mod .. " + ALT + K", hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true })
hl.bind(mod .. " + ALT + L", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })
hl.bind(mod .. " + ALT + left", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
hl.bind(mod .. " + ALT + right", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })
hl.bind(mod .. " + ALT + up", hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true })
hl.bind(mod .. " + ALT + down", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true })

-- Workspaces 1-10 on SUPER+0-9, 11-20 on SUPER+CTRL+0-9
for i = 1, 10 do
	local key = tostring(i % 10)
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = tostring(i) }))
	hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = tostring(i) }))
	hl.bind(mod .. " + CTRL + " .. key, hl.dsp.focus({ workspace = tostring(i + 10) }))
	hl.bind(mod .. " + CTRL + SHIFT + " .. key, hl.dsp.window.move({ workspace = tostring(i + 10) }))
end

hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Virtual resolution switcher
hl.bind(mod .. " + F1", hl.dsp.exec_cmd("~/.local/bin/switch-virtual-res.sh retroid"))
hl.bind(mod .. " + F2", hl.dsp.exec_cmd("~/.local/bin/switch-virtual-res.sh ipad-family"))
hl.bind(mod .. " + F4", hl.dsp.exec_cmd("~/.local/bin/switch-virtual-res.sh off"))

-- Window rules
for _, class in ipairs({ "pavucontrol", "blueman-manager", "nm-connection-editor", "imv", "easyeffects" }) do
	hl.window_rule({ name = "float-" .. class, match = { class = "^(" .. class .. ")$" }, float = true })
end
hl.window_rule({ name = "float-pip", match = { title = "^(Picture-in-Picture)$" }, float = true })
hl.window_rule({ name = "size-dolphin", match = { class = "^(org.kde.dolphin)$" }, size = "900 600" })
hl.window_rule({ name = "size-pavucontrol", match = { class = "^(pavucontrol)$" }, size = "700 450" })

hl.window_rule({
	name = "kando",
	match = { class = "menu.kando.Kando", title = "Kando Menu" },
	no_blur = true,
	opaque = true,
	move = { 0, 0 },
	rounding = 0,
	size = { "100%", "100%" },
	border_size = 0,
	no_anim = true,
	float = true,
	pin = true,
})

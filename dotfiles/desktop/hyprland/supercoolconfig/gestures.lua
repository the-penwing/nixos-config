hl.config({
	input = {
		kb_layout = "au",
		follow_mouse = 1,
		sensitivity = 0.15,
		accel_profile = "flat",
		kb_options = "compose:ralt",
		touchpad = {
			natural_scroll = true,
			tap_to_click = true,
			drag_lock = true,
			scroll_factor = 1.2,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.gesture({
	fingers = 3,
	direction = "up",
	action = "workspace",
	workspace = "special:magic",
})

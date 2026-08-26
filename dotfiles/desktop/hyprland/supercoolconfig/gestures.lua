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
			drag_lock = 0,
			tap_and_drag = true,
			scroll_factor = 1.2,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "vertical",
	action = "workspace",
})

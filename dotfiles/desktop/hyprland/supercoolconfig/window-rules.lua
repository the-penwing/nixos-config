local rules = {
	{
		name = "float-pavucontrol",
		match = { class = "^(pavucontrol)$" },
		float = true,
	},
	{
		name = "float-blueman-manager",
		match = { class = "^(blueman-manager)$" },
		float = true,
	},
	{
		name = "float-nm-connection-editor",
		match = { class = "^(nm-connection-editor)$" },
		float = true,
	},
	{
		name = "float-imv",
		match = { class = "^(imv)$" },
		float = true,
	},
	{
		name = "float-easyeffects",
		match = { class = "^(easyeffects)$" },
		float = true,
	},
	{
		name = "float-picture-in-picture",
		match = { title = "^(Picture-in-Picture)$" },
		float = true,
	},
	{
		name = "size-dolphin",
		match = { class = "^(org.kde.dolphin)$" },
		size = "900 600",
	},
	{
		name = "size-pavucontrol",
		match = { class = "^(pavucontrol)$" },
		size = "700 450",
	},
}

for _, rule in ipairs(rules) do
	hl.window_rule(rule)
end

hl.exec_cmd("hyprswitch init --show-title &")

local mainMod = "SUPER"
hl.bind("ALT + Tab", hl.dsp.window.cycle_next())
hl.bind("ALT + SHIFT + Tab", hl.dsp.window.cycle_next({ next = false }))
hl.bind(mainMod .. " + P", hl.dsp.window.pin({ action = "toggle" }))
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd("~/.local/bin/switch-virtual-res.sh retroid"))
hl.bind(mainMod .. " + F2", hl.dsp.exec_cmd("~/.local/bin/switch-virtual-res.sh ipad-family"))
hl.bind(mainMod .. " + F4", hl.dsp.exec_cmd("~/.local/bin/switch-virtual-res.sh off"))

local exec_once_commands = {
	"hyprpolkitagent",
	"wl-paste --watch cliphist store",
	"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
	"caelestia shell",
}

hl.on("hyprland.start", function()
	for _, command in ipairs(exec_once_commands) do
		hl.exec_cmd(command)
	end
end)

local env_vars = {
	XCURSOR_SIZE = "24",
	XCURSOR_THEME = "Bibata-Modern-Classic",
	HYPRCURSOR_SIZE = "24",
	XDG_CURRENT_DESKTOP = "Hyprland",
	XDG_SESSION_TYPE = "wayland",
	XDG_SESSION_DESKTOP = "Hyprland",
	QT_QPA_PLATFORM = "wayland",
	QT_QPA_PLATFORMTHEME = "qt6ct",
	GDK_BACKEND = "wayland,x11",
	MOZ_ENABLE_WAYLAND = "1",
	QS_ICON_THEME = "Dracula",
}

for key, value in pairs(env_vars) do
	hl.env(key, value)
end

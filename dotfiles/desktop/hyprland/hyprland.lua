local modules = {
    "supercoolconfig/colors",
    "supercoolconfig/monitors",
    "supercoolconfig/autostart-enviroment",
    "supercoolconfig/look-and-feel",
    "supercoolconfig/gestures",
    "supercoolconfig/keybinds",
    "supercoolconfig/window-rules",
}

for _, module in ipairs(modules) do
    require(module)
end

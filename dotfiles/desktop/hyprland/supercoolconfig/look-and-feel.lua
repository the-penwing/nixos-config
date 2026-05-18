local colors = require("supercoolconfig/colors")

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border = {
                colors = {
                    "rgba(" .. colors.primary .. "ff)",
                    "rgba(" .. colors.secondary .. "ff)",
                },
                angle = 45,
            },
            inactive_border = "rgba(" .. colors.neutral_variant_paletteKeyColor .. "ff)",
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
        blur = {
            enabled = true,
            size = 6,
            passes = 2,
            vibrancy = 0.1696,
            special = true,
        },
    },
    animations = {
        enabled = true,
    },
    master = {
        new_status = "master",
    },
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
    cursor = {
        no_hardware_cursors = 0,
        enable_hyprcursor = true,
    },
    xwayland = {
        force_zero_scaling = true,
    },
})

local curves = {
    {
        name = "easeOutQuint",
        points = { { 0.23, 1 }, { 0.32, 1 } },
    },
    {
        name = "easeInOutCubic",
        points = { { 0.65, 0.05 }, { 0.35, 0.95 } },
    },
    {
        name = "snappyBounce",
        points = { { 0.05, 0.9 }, { 0.1, 1.05 } },
    },
    {
        name = "linear",
        points = { { 0, 0 }, { 1, 1 } },
    },
}

for _, curve in ipairs(curves) do
    hl.curve(curve.name, {
        type = "bezier",
        points = curve.points,
    })
end

local animations = {
    { leaf = "windows", speed = 5, bezier = "snappyBounce", style = "slide" },
    { leaf = "windowsOut", speed = 4, bezier = "easeOutQuint", style = "slide" },
    { leaf = "windowsMove", speed = 4, bezier = "easeInOutCubic" },
    { leaf = "border", speed = 10, bezier = "linear" },
    { leaf = "borderangle", speed = 30, bezier = "linear", style = "loop" },
    { leaf = "fade", speed = 5, bezier = "easeOutQuint" },
    { leaf = "workspaces", speed = 5, bezier = "easeOutQuint", style = "slidevert" },
    { leaf = "specialWorkspace", speed = 5, bezier = "snappyBounce", style = "slidevert" },
}

for _, animation in ipairs(animations) do
    hl.animation({
        leaf = animation.leaf,
        enabled = true,
        speed = animation.speed,
        bezier = animation.bezier,
        style = animation.style,
    })
end

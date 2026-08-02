# ============================================================================
# Auto-start Hyprland (must be last - exec terminates shell)
# ============================================================================
[[ -z "$WAYLAND_DISPLAY" && "$(tty)" == "/dev/tty1" ]] && exec start-hyprland

# Ensure clean exit status for sourcing
true

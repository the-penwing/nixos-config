# Config approach

| Layer | Tool | Description |
|---|---|---|
| System | NixOS flake | Declarative OS config — bootloader, kernel, services, system packages |
| Home | home-manager | Per-user dotfiles, shell, editor, desktop app config |
| Dotfiles | Plain config files | Symlinked by home-manager into `~/.config/` |
| Key remapping | keyd | Kernel-level remapping applied before Hyprland sees any key event |
| Wayland compositor | Hyprland | Application keybindings, window rules, workspace management |

## Two-layer input system

Key remapping is split between **keyd** (kernel level) and **Hyprland** (compositor level) to keep concerns separated:

- **keyd** (`modules/system/input.nix`) handles universal remaps that should work in every app regardless of focus — Caps Lock layer, `Super+Z/X/A` editing shortcuts.
- **Hyprland** (`dotfiles/desktop/hyprland/hyprland.conf`) handles everything compositor-specific — launching apps, window management, workspace switching.

## Desktop session

There is no display manager. TTY1 auto-logs in as `benvl` and `.zshrc` starts Hyprland automatically.

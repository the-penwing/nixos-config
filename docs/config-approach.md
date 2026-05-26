# Config approach

| Layer | Tool | Description |
|---|---|---|
| System | NixOS flake | Declarative OS config (boot/services/networking/packages) |
| Home | home-manager | Per-user shell + desktop service configuration |
| Package source | `packages.nix` | Single source of truth for package categories and default app metadata |
| Overlays | `overlays/default.nix` | Central place for package overrides |
| Dotfiles | Plain files | Synced into `~/.config` via `scripts/sync-dotfiles` |
| Key remapping | keyd | Kernel-level remapping before Hyprland |
| Wayland compositor | Hyprland | Workspace/window policy + launch bindings |

## Session model

No display manager is used. TTY1 autologins and launches Hyprland through shell startup.

## File manager model

- Dolphin is the GUI default (`Super+E`, MIME default for directories)
- Yazi is terminal-first (`fm` alias + `yy` integration for shell cwd handoff)

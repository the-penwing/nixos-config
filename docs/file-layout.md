# File layout

```
nixos-config/
  flake.nix                   # entry point; all inputs & nixos-laptop output
  home.nix                    # home-manager entry; imports ./modules/home
  ARCHITECTURE.md             # high-level architecture and design decisions
  lib/
    mkDevShell.nix            # shared dev-shell zsh/common-tool wrapper
    mkMicrobitShell.nix       # shared helper for micro:bit dev shells

  hosts/nixos-laptop/
    configuration.nix         # system entry point; imports ../../modules/system
    hardware-configuration.nix

  modules/
    system/
      default.nix             # explicit system module entrypoint/import list
      ...                     # boot, networking, hardware, services, packages, input
    home/
      default.nix             # explicit home module entrypoint/import list
      ...                     # shell, editor, desktop

  dotfiles/
    desktop/                  # hyprland, waybar, wofi, rofi, wlogout
    shell/                    # zsh, starship, tmux
    editor/                   # nvim (LazyVim)
    apps/                     # ghostty, btop, fastfetch, lazygit, waypaper, nm-dmenu
    theme/                    # gtk, dunst
```

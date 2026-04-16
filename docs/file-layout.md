# File layout

```
nixos-config/
  flake.nix                   # entry point; all inputs & nixos-laptop output
  home.nix                    # home-manager entry

  hosts/nixos-laptop/
    configuration.nix         # system entry point
    hardware-configuration.nix

  modules/
    system/                   # boot, networking, hardware, services, packages, input
    home/                     # shell, editor, desktop

  dotfiles/
    desktop/                  # hyprland, waybar, wofi, rofi, wlogout
    shell/                    # zsh, starship, tmux
    editor/                   # nvim (LazyVim)
    apps/                     # ghostty, btop, fastfetch, lazygit, waypaper, nm-dmenu
    theme/                    # gtk, dunst
```

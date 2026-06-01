# File layout

```text
nixos-config/
  flake.nix
  packages.nix
  home.nix
  overlays/default.nix
  scripts/
    sync-dotfiles
    rebuild
    rollback

  hosts/nixos-p14s/
    configuration.nix
    hardware-configuration.nix

  modules/
    system/
      default.nix
      boot.nix
      desktop.nix
      hardware.nix
      input.nix
      networking.nix
      packages.nix
      performance.nix
      services.nix
      users.nix
    home/
      default.nix
      desktop.nix
      shell.nix

  dotfiles/
    apps/yazi/
    desktop/hyprland/
    desktop/caelestia/
    shell/
    editor/
```

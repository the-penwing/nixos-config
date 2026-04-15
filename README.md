# nixos-config

NixOS configuration for `nixos-laptop` using flakes and home-manager.

## Structure

```
├── flake.nix                        # Flake entry point
├── home.nix                         # Home-manager entry (imports modules)
├── hosts/
│   └── nixos-laptop/                # Host-specific configs
│       ├── configuration.nix        # System configuration (imports modules)
│       ├── hardware-configuration.nix
│       └── secrets/
│           └── root.crt
├── modules/
│   ├── system/                      # System-level modules
│   │   ├── boot.nix
│   │   ├── networking.nix
│   │   ├── hardware.nix
│   │   ├── services.nix
│   │   └── packages.nix
│   └── home/                        # Home-manager modules
│       ├── shell.nix
│       ├── editor.nix
│       └── desktop.nix
├── packages/
│   └── turntable.nix                # Custom package definitions
└── dotfiles/
    ├── desktop/                     # Wayland/Desktop configs
    │   ├── hyprland/
    │   ├── waybar/
    │   ├── rofi/
    │   ├── wofi/
    │   └── wlogout/
    ├── shell/                       # Shell & terminal configs
    │   ├── zsh/
    │   ├── starship.toml
    │   └── tmux/
    ├── editor/                      # Editor configs
    │   └── nvim/
    ├── apps/                        # Application configs
    │   ├── fastfetch/
    │   ├── lazygit/
    │   ├── ghostty/
    │   ├── btop/
    │   └── networkmanager-dmenu/
    └── theme/                       # Theme & appearance
        ├── gtk-3.0/
        └── dunst/
```

## Applying

```bash
sudo nixos-rebuild switch --flake .#nixos-laptop
```

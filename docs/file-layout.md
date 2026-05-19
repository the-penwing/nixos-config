# File layout

```
nixos-config/
  flake.nix                   # entry point; all inputs & nixos-t14s output
  home.nix                    # home-manager entry; imports ./modules/home
  ARCHITECTURE.md             # high-level architecture and design decisions
  lib/
    mkDevShell.nix            # shared dev-shell wrapper (bash + starship/common tooling)
    mkMicrobitShell.nix       # shared helper for micro:bit dev shells
  scripts/
    sync-dotfiles.sh          # sync dotfiles ↔ ~/.config (repo is source of truth)

  hosts/nixos-t14s/
    configuration.nix         # system entry point; imports ../../modules/system
    hardware-configuration.nix

  modules/
    system/
      default.nix             # explicit system module entrypoint/import list
      ...                     # boot, networking, hardware, services, packages, input
    home/
      default.nix             # explicit home module entrypoint/import list
      ...                     # shell, desktop

  dotfiles/
    desktop/
      hyprland/
        hyprland.lua          # Lua entrypoint for Hyprland config
        supercoolconfig/*.lua # modular Hyprland sections
      caelestia/
    shell/
      zsh/
        .zshrc                # small source-only entrypoint
        zshrc.d/*.zsh         # modular zsh sections
      tmux/
      starship.toml
    editor/                   # nvim (AstroNvim)
    apps/                     # ghostty, btop, fastfetch
    theme/                    # gtk

  docs/
    performance-improvements.md # tracked performance opportunities/review checklist
  dev-envs/
    README.md                 # dev-shell overview + micro:bit workflow docs
```

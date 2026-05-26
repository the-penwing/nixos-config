# Architecture

## Entry points

- `flake.nix`: flake inputs, outputs, and dev shells.
- `hosts/nixos-t14s/configuration.nix`: host-specific NixOS entry.
- `home.nix`: Home Manager entry for user-level config.

## System module graph

`modules/system/default.nix` composes:

- `boot.nix`
- `desktop.nix`
- `hardware.nix`
- `input.nix`
- `networking.nix`
- `packages.nix`
- `performance.nix`
- `services.nix`
- `users.nix`

## Package architecture

`packages.nix` is the single package catalogue. It exports:

- package categories (`core`, `dev`, `gui`, `security`, etc.)
- flattened `systemPackages`
- `defaults` desktop IDs
- `mimeDefaults` consumed by the desktop module

## Dotfile architecture

`dotfiles/` keeps app config source-of-truth; `scripts/sync-dotfiles` synchronises to and from `$HOME`.

Notable paths:

- `dotfiles/apps/yazi/` (terminal file manager)
- `dotfiles/desktop/hyprland/` (Wayland compositor)
- `dotfiles/desktop/caelestia/` (shell UI layer)
- `dotfiles/editor/nvim/` (AstroNvim profile)

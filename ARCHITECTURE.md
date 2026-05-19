# Architecture

This repository uses a layered Nix flake layout:

- `flake.nix` is the top-level entrypoint for both host configuration and development shells.
- `hosts/nixos-t14s/configuration.nix` is the NixOS host entrypoint.
- `home.nix` is the home-manager entrypoint for user-level configuration.

## Module entrypoints

To make module loading explicit:

- `modules/system/default.nix` imports all system modules (`boot`, `networking`, `hardware`, `services`, `packages`, `input`).
- `modules/home/default.nix` imports all home-manager modules (`shell`, `desktop`).

This keeps host/user entry files short while making the module graph easy to scan.

## Dotfiles and home-manager

`modules/home/*` own declarative home-manager settings and package selections.
`dotfiles/*` store concrete app configuration files, synced with `scripts/sync-dotfiles.sh`.

Current dotfile areas:

- `dotfiles/desktop`: compositor and desktop UI config
  - `hyprland/hyprland.lua` loads modular config from `hyprland/supercoolconfig/*.lua`
  - `caelestia/` holds Caelestia shell config and monitor profiles
- `dotfiles/shell`: zsh, tmux, starship
  - `.zshrc` is now a small entrypoint that sources `~/.config/zsh/zshrc.d/*.zsh`.
- `dotfiles/editor`: AstroNvim config
- `dotfiles/apps`: per-app configs (ghostty, btop, fastfetch)
- `dotfiles/theme`: GTK theme files

## Development shells

Dev shells are defined in `flake.nix` using:

- `lib/mkDevShell.nix` for shared shell behavior (starship + common CLI QoL tooling)
- `lib/mkMicrobitShell.nix` for micro:bit-specific composition

Defined shells:

- `default`
- `pawn-appetit`
- `microbit-python`
- `microbit-rust`
- `microbit` (combined Python + Rust)
- `bash-scripting`

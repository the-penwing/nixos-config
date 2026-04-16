# Architecture

This repository uses a layered Nix flake layout:

- `flake.nix` is the top-level entrypoint for both host configuration and development shells.
- `hosts/nixos-laptop/configuration.nix` is the NixOS host entrypoint.
- `home.nix` is the home-manager entrypoint for user-level configuration.

## Module entrypoints

To make module loading explicit:

- `modules/system/default.nix` imports all system modules (`boot`, `networking`, `hardware`, `services`, `packages`, `input`).
- `modules/home/default.nix` imports all home-manager modules (`shell`, `editor`, `desktop`).

This keeps host/user entry files short while making the module graph easy to scan.

## Dotfiles and home-manager

`modules/home/*` own declarative home-manager settings and package selections.
`dotfiles/*` store concrete app configuration files that home-manager links into place.

Current dotfile areas:

- `dotfiles/desktop`: compositor and desktop UI config
- `dotfiles/shell`: zsh, tmux, starship
- `dotfiles/editor`: Neovim config
- `dotfiles/apps`: per-app configs
- `dotfiles/theme`: GTK and notification theme files

## Development shells

Micro:bit shells are defined in `flake.nix` using `lib/mkMicrobitShell.nix` to avoid duplication:

- `microbit-python`
- `microbit-rust`
- `microbit` (combined Python + Rust)

This centralizes shared tooling while keeping shell-specific behavior explicit.

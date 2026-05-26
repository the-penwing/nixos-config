# nixos-config

Production-oriented NixOS + Home Manager configuration for **ThinkPad T14s Gen 2 (Ryzen 5 Pro)**.

## Quick start

```bash
# Apply dotfiles into ~/.config
./scripts/sync-dotfiles pull

# Validate flake outputs (no build)
nix flake check --no-build

# Rebuild host
./scripts/rebuild

# Roll back to previous generation
./scripts/rollback
```

## Structure

```text
.
├── flake.nix                          # flake inputs/outputs + dev shells
├── packages.nix                       # single source of truth for package categories + app defaults
├── overlays/default.nix               # package overrides
├── hosts/nixos-t14s/configuration.nix # host entrypoint
├── modules/system/                    # system modules by concern
│   ├── boot.nix
│   ├── desktop.nix
│   ├── hardware.nix
│   ├── input.nix
│   ├── networking.nix
│   ├── packages.nix
│   ├── performance.nix
│   ├── services.nix
│   └── users.nix
├── modules/home/                      # home-manager modules
├── dotfiles/                          # app/user config synced into $HOME
└── scripts/                           # shell scripts (no extensions)
```

## Package management

All package lists live in `packages.nix`.

- `categories.core`
- `categories.cli`
- `categories.dev`
- `categories.gui`
- `categories.desktop`
- `categories.security`
- `categories.media`
- `categories.misc`

### Add/remove packages

1. Edit the correct category in `packages.nix`.
2. Rebuild with `./scripts/rebuild`.
3. Verify the package resolves (`command -v <tool>` or app launcher search).

## Default apps and MIME handlers

Default browser/editor/file manager/PDF handlers are declared in `packages.nix` (`defaults` + `mimeDefaults`) and consumed by `modules/system/desktop.nix`.

This keeps package choice and default-association logic in one place.

## Yazi + Dolphin workflow

- **Yazi**: terminal-first, keyboard-driven navigation (`fm` alias / `yy` function).
- **Dolphin**: GUI workflows, bulk file actions, service-menu integrations.

See `YAZI_SETUP.md` for keybindings and shell integration details.

## Common workflows

### Update flake inputs

```bash
nix flake update
./scripts/rebuild
```

### Apply local dotfile edits back into repo

```bash
./scripts/sync-dotfiles push
```

### Clean old generations/store data

```bash
sudo nix-collect-garbage --delete-older-than 7d
```

## Troubleshooting

- **`nix: command not found`**: run commands on the NixOS host or inside a Nix-enabled shell.
- **Yazi does not change directory after exit**: ensure shell is Zsh and `yy` function from `dotfiles/shell/zsh/zshrc.d/20-integrations.zsh` is loaded.
- **Default app mismatch**: check desktop file IDs in `packages.nix -> defaults` and rebuild.
- **Missing dotfile changes**: run `./scripts/sync-dotfiles pull` again to refresh target files.

## Validation checklist

```bash
nix flake check --no-build
nix fmt
./scripts/rebuild --show-trace
```

## Changelog (overhaul)

- Reorganized system modules by concern (desktop/services/performance/users).
- Added `packages.nix` package catalogue + MIME/default app metadata.
- Replaced Thunar with Dolphin + Yazi (including sync + shell integration).
- Added no-extension workflow scripts: `rebuild`, `rollback`, `sync-dotfiles`.
- Added performance audit and implementation notes in `OPTIMISATIONS.md`.

## Reference docs

- NixOS manual: https://nixos.org/manual/nixos/stable/
- Flakes wiki: https://nixos.wiki/wiki/Flakes
- Home Manager manual: https://nix-community.github.io/home-manager/
- XDG MIME docs (NixOS option reference): https://search.nixos.org/options
- Yazi docs: https://yazi-rs.github.io/docs/

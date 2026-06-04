# nixos-config

Production-oriented NixOS + Home Manager configuration for **ThinkPad P14s Gen 2 (Ryzen 5 Pro)**.

## Quick Start

```bash
# Clone and enter directory
git clone https://github.com/<your-repo>/nixos-config
cd nixos-config

# Apply dotfiles into ~/.config
./scripts/sync-config pull

# Validate flake outputs (no build)
nix flake check

# Rebuild system
sudo nixos-rebuild switch

# Roll back if needed
sudo nixos-rebuild switch --rollback
```

## Documentation

Start here:

- **[docs/SETUP.md](docs/SETUP.md)** – Initial setup and installation
- **[docs/MAINTENANCE.md](docs/MAINTENANCE.md)** – How to edit configuration and add packages
- **[docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)** – System design and philosophy
- **[docs/README.md](docs/)** – Full documentation index

## Repository Structure

```
nixos-config/
├── dev-envs/
│   ├── base-shell.nix
│   ├── bash-scripting.nix
│   ├── default.nix
│   ├── pawn-appetit.nix
│   └── rust.nix
├── docs/
├── dotfiles/
│   ├── apps/
│   │   ├── btop/
│   │   ├── fastfetch/
│   │   ├── ghostty/
│   │   └── yazi/
│   ├── desktop/
│   │   ├── caelestia/
│   │   └── hyprland/
│   ├── editor/
│   │   └── nvim/
│   ├── shell/
│   │   ├── starship.toml
│   │   ├── tmux/
│   │   ├── zellij/
│   │   └── zsh/
│   │       └── zshrc.d/
│   └── theme/
│       └── gtk-3.0/
├── flake.lock
├── flake.nix
├── home.nix
├── hosts/
├── modules/
│   ├── home/
│   │   ├── default.nix
│   │   ├── desktop.nix
│   │   └── shell.nix
│   └── system/
│       ├── boot.nix
│       ├── default.nix
│       ├── desktop.nix
│       ├── hardware.nix
│       ├── input.nix
│       ├── networking.nix
│       ├── package-list.nix
│       ├── packages.nix
│       ├── performance.nix
│       ├── services.nix
│       └── users.nix
├── overlays/
│   └── default.nix
├── README.md
└── scripts/
    ├── rebuild
    ├── rollback
    └── sync-dotfiles
```
## Package Management

All packages are defined in `nix/packages.nix` with semantic grouping:

- **System Utilities** – Core tools (curl, wget, git, etc.)
- **Terminal & CLI** – Modern CLI tools (bat, eza, fzf, etc.)
- **Development** – Compilers, LSPs, version managers
- **GUI Applications** – Desktop apps (Discord, Firefox, etc.)
- **Desktop Environment** – Themes, cursors, Wayland tools
- **Security & Networking** – Penetration testing, network tools
- **Media & Archives** – Video, audio, and archive utilities
- **Miscellaneous** – Tools that don't fit elsewhere

### Add/Remove Packages

See [docs/MAINTENANCE.md#adding-packages](docs/MAINTENANCE.md#adding-packages) for detailed instructions.

Quick version:

1. Edit the appropriate category in `nix/packages.nix`
2. Test with `nixos-rebuild dry-run`
3. Apply with `sudo nixos-rebuild switch`

## Dotfiles Sync

Shell and application configuration is stored in `dotfiles/` and synced to `~/.config`, `~`, etc. using the sync script.

```bash
# Sync from dotfiles to home directory
./scripts/sync-config pull

# Sync changes from home directory back to dotfiles
./scripts/sync-config push
```

### Zsh Configuration

Split into logical files under `dotfiles/shell/zsh/zshrc.d/`:

- `00-oh-my-zsh.zsh` – Oh My Zsh setup and plugins
- `10-environment.zsh` – Environment variables
- `20-integrations.zsh` – Tool integrations (direnv, fzf, etc.)
- `30-aliases.zsh` – Command aliases
- `40-hyprland.zsh` – Hyprland-specific config
- `50-starship.zsh` – Starship prompt configuration

See [scripts/README.md](scripts/README.md) and [dotfiles/README.md](dotfiles/README.md) for details.

## Common Workflows

### Add a development tool

1. Find it on https://search.nixos.org/packages
2. Add to appropriate category in `nix/packages.nix`
3. Rebuild: `sudo nixos-rebuild switch`

### Update zsh aliases

1. Edit `dotfiles/shell/zsh/zshrc.d/30-aliases.zsh`
2. Sync: `./scripts/sync-config pull`
3. Test: `zsh -i` and verify
4. Commit: `git add dotfiles/ && git commit -m "shell: update aliases"`

### Customize desktop environment

1. Edit Hyprland config: `dotfiles/desktop/hyprland/`
2. Or desktop settings: `modules/system/desktop.nix`
3. Rebuild: `sudo nixos-rebuild switch`

### Rebuild after changes

```bash
# Dry-run test (no apply)
nixos-rebuild dry-run

# Build and apply
sudo nixos-rebuild switch

# With detailed output
sudo nixos-rebuild switch -v
```

## Troubleshooting

- **Packages not available**: Rebuild with `sudo nixos-rebuild switch`
- **Dotfiles not syncing**: Run `./scripts/sync-config pull` and verify files exist
- **Shell changes not taking effect**: Start a new shell or `exec zsh`
- **Build fails**: Run with `--show-trace` and check error messages
- **Need to rollback**: Use `sudo nixos-rebuild switch --rollback`

See [docs/MAINTENANCE.md](docs/MAINTENANCE.md) for more troubleshooting.

## Reference Documentation

- [docs/SETUP.md](docs/SETUP.md) – Initial setup and first-time configuration
- [docs/MAINTENANCE.md](docs/MAINTENANCE.md) – How to maintain and edit the config
- [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) – System design and philosophy
- [scripts/README.md](scripts/README.md) – Sync script documentation
- [dotfiles/README.md](dotfiles/README.md) – Dotfiles structure and workflow

## External References

- NixOS manual: https://nixos.org/manual/nixos/stable/
- Flakes wiki: https://nixos.wiki/wiki/Flakes
- Home Manager manual: https://nix-community.github.io/home-manager/
- Nixpkgs search: https://search.nixos.org/packages

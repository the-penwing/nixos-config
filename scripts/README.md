# Scripts

This directory contains utility scripts for managing NixOS configuration and dotfiles.

## sync-config

Unified configuration sync script that synchronizes dotfiles to their proper locations in the home directory.

### Usage

```bash
# Pull mode (default): sync from dotfiles/ to ~/.config, ~, etc.
./scripts/sync-config pull

# Push mode: sync from ~/.config, ~, etc. back to dotfiles/
./scripts/sync-config push
```

### Behavior

- **Pull (default)**: Copies files from `dotfiles/` to their destination locations (e.g., `~/.config`, `~/.zshrc`)
- **Push**: Copies files from destination locations back to `dotfiles/` for version control
- **Idempotent**: Safe to run multiple times; uses `rsync --delete` to maintain consistency
- **Logging**: Each sync pair shows source and destination for clarity

### Managed Dotfiles

| Source | Destination | Purpose |
|--------|-------------|---------|
| `dotfiles/editor/nvim/` | `~/.config/nvim/` | Neovim configuration |
| `dotfiles/desktop/hyprland/` | `~/.config/hypr/` | Hyprland window manager config |
| `dotfiles/desktop/caelestia/` | `~/.config/caelestia/` | Caelestia desktop environment |
| `dotfiles/apps/ghostty/` | `~/.config/ghostty/` | Ghostty terminal emulator |
| `dotfiles/apps/btop/` | `~/.config/btop/` | btop system monitor |
| `dotfiles/apps/fastfetch/` | `~/.config/fastfetch/` | fastfetch system info |
| `dotfiles/apps/yazi/` | `~/.config/yazi/` | Yazi file manager |
| `dotfiles/shell/zsh/.zshrc` | `~/.zshrc` | Main zsh config (modular entrypoint) |
| `dotfiles/shell/zsh/zshrc.d/` | `~/.config/zsh/zshrc.d/` | Split zsh configuration files |
| `dotfiles/shell/tmux/.tmux.conf` | `~/.tmux.conf` | tmux configuration |
| `dotfiles/shell/starship.toml` | `~/.config/starship.toml` | Starship prompt configuration |
| `dotfiles/theme/gtk-3.0/` | `~/.config/gtk-3.0/` | GTK theme configuration |

### Adding New Dotfiles

To add a new dotfile or directory to sync:

1. Place the file/directory in `dotfiles/` following the structure above
2. Add a new entry to the `SYNC_PAIRS` array in `scripts/sync-config`
3. Run `./scripts/sync-config pull` to sync
4. Verify the file is in the correct location
5. Commit both changes

Example:

```bash
# Add zoxide config
mkdir -p dotfiles/shell/zoxide
cp ~/.config/zoxide/db.json dotfiles/shell/zoxide/
# Edit scripts/sync-config and add:
# "dotfiles/shell/zoxide:~/.config/zoxide"
./scripts/sync-config pull
```

## Other Scripts

- **rebuild**: NixOS system rebuild wrapper
- **rollback**: NixOS rollback helper

## Legacy Scripts

- `sync-dotfiles`: Superseded by `sync-config`
- `sync-zshrc-d`: Superseded by `sync-config` (handles split zsh config)

These are kept for compatibility but `sync-config` is the recommended approach.

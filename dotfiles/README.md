# Dotfiles

Configuration and customization files synchronized to the home directory via the `sync-config` script.

## Structure

```
dotfiles/
├── editor/
│   └── nvim/              → ~/.config/nvim/
├── desktop/
│   ├── hyprland/          → ~/.config/hypr/
│   └── caelestia/         → ~/.config/caelestia/
├── apps/
│   ├── ghostty/           → ~/.config/ghostty/
│   ├── btop/              → ~/.config/btop/
│   ├── fastfetch/         → ~/.config/fastfetch/
│   └── yazi/              → ~/.config/yazi/
├── shell/
│   ├── zsh/
│   │   ├── .zshrc         → ~/.zshrc
│   │   └── zshrc.d/       → ~/.config/zsh/zshrc.d/
│   ├── tmux/
│   │   └── .tmux.conf     → ~/.tmux.conf
│   └── starship.toml      → ~/.config/starship.toml
└── theme/
    └── gtk-3.0/           → ~/.config/gtk-3.0/
```

## Syncing

Dotfiles are synchronized using the `sync-config` script:

```bash
# Sync from dotfiles/ to home directory
./scripts/sync-config pull

# Sync from home directory back to dotfiles/
./scripts/sync-config push
```

Run `./scripts/sync-config pull` after rebuilding NixOS or cloning the repo to restore your configuration.

## Shell Configuration (zsh)

The zsh configuration uses a modular approach:

### `~/.zshrc` (Modular Entrypoint)

Located at `dotfiles/shell/zsh/.zshrc`, this file:
- Sources all `.zsh` files from `~/.config/zsh/zshrc.d/` in alphabetical order
- Configures Oh My Zsh
- Sets up XDG data directories

### `~/.config/zsh/zshrc.d/` (Split Configuration)

Split into numbered files for clarity:

| File | Purpose |
|------|---------|
| `00-oh-my-zsh.zsh` | Oh My Zsh setup and plugins |
| `10-environment.zsh` | Environment variables and paths |
| `20-integrations.zsh` | direnv, fzf, yazi, and tool integrations |
| `30-aliases.zsh` | Command aliases |
| `40-hyprland.zsh` | Hyprland-specific configuration |
| `50-starship.zsh` | Starship prompt configuration |

### Adding New Shell Configuration

1. Create a new file in `dotfiles/shell/zsh/zshrc.d/` with a descriptive name and `NN-` prefix
2. Add your configuration
3. Run `./scripts/sync-config pull`
4. Test with `zsh`

Example:

```bash
# Create a new configuration file
cat > dotfiles/shell/zsh/zshrc.d/60-custom.zsh << 'EOF'
# My custom configuration
alias ll='ls -lah'
EOF

# Sync to home directory
./scripts/sync-config pull

# Verify it's loaded
grep "ll=" ~/.config/zsh/zshrc.d/60-custom.zsh
```

## System vs. User Configuration

### System Level (NixOS)

Managed in `configuration.nix` via `modules/system/`:
- `programs.zsh.enable = true;` — Install zsh
- `programs.zoxide.enable = true;` — Install zoxide directory jumper
- Other system packages and services

### Home Level (home-manager)

Managed in `home.nix` via `modules/home/shell.nix`:
- Environment variables (EDITOR, MANPAGER, etc.)
- Session path configuration
- Home packages (zsh-autosuggestions, zsh-syntax-highlighting, etc.)
- Tool enablement (direnv, starship, fzf) without automatic zsh integration

### User Configuration (Manual)

Managed in `dotfiles/`:
- All zsh config in `dotfiles/shell/zsh/`
- Synced manually to `~/.config/zsh/` and `~/.zshrc`
- Manual integrations in zshrc.d (direnv hook, etc.)

This separation ensures:
- **Manual control**: No hidden home-manager initialization wrappers
- **Simplicity**: Clear, auditable shell startup
- **Reproducibility**: Easy to modify and test configuration

## Editing Dotfiles

### When to Edit in Repository

Edit in the repository (`dotfiles/`) when:
- Making permanent changes to configuration
- Committing to version control

### Workflow

```bash
# 1. Edit in repository
vim dotfiles/shell/zsh/zshrc.d/30-aliases.zsh

# 2. Sync to home directory
./scripts/sync-config pull

# 3. Test
zsh
alias myalias

# 4. Commit
git add dotfiles/shell/zsh/zshrc.d/30-aliases.zsh
git commit -m "shell: add useful aliases"
```

### Syncing Changes Back

If you edit configs directly in `~/.config/` for testing:

```bash
# Test a change directly
echo "export TEST_VAR=1" >> ~/.config/zsh/zshrc.d/60-test.zsh

# Push back to repository
./scripts/sync-config push

# Commit the change
git add dotfiles/
git commit -m "shell: add test configuration"
```

## Troubleshooting

### Shell Startup is Slow

- Profile with: `time zsh -i -c exit`
- Debug with: `zsh -x -i -c exit 2>&1 | head -50`
- Main culprit is usually Oh My Zsh's `compinit` completion initialization

### Configuration Not Loading

1. Verify file is synced: `ls -la ~/.config/zsh/zshrc.d/`
2. Check permissions: `stat ~/.config/zsh/zshrc.d/xx-*.zsh`
3. Check .zshrc sources the directory: `cat ~/.zshrc | grep zshrc.d`
4. Re-sync: `./scripts/sync-config pull`

### Missing Tools

If a tool isn't found after configuration:
- Check it's installed: `which <tool>`
- If missing, it's declared in system (`configuration.nix`) or home (`modules/home/`)
- Rebuild with: `nixos-rebuild switch`

## Key Configuration Files

- `dotfiles/shell/zsh/.zshrc` — Main entry point, sources zshrc.d
- `dotfiles/shell/zsh/zshrc.d/00-oh-my-zsh.zsh` — Oh My Zsh plugins and theme
- `dotfiles/shell/zsh/zshrc.d/20-integrations.zsh` — Tool integrations (direnv, fzf, yazi)
- `dotfiles/shell/starship.toml` — Starship prompt theme and behavior
- `dotfiles/shell/tmux/.tmux.conf` — tmux key bindings and options

## Version Control

Dotfiles are version-controlled. Always commit meaningful changes:

```bash
# Add and commit changes
git add dotfiles/
git commit -m "shell: improve zsh configuration"

# Push to remote
git push origin main
```

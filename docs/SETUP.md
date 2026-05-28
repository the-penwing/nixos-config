# Setup Guide

Step-by-step instructions for setting up and testing the NixOS configuration.

## Initial Setup

### 1. Clone the Repository

```bash
git clone https://github.com/<your-repo>/nixos-config
cd nixos-config
```

### 2. Review Configuration

Before applying, review the current system settings:

- **Hardware**: Check `hosts/<hostname>/hardware-configuration.nix`
- **System**: Review `modules/system/` for device-specific settings
- **Packages**: Look through `nix/packages.nix` for pre-installed software
- **Desktop**: Check `modules/system/desktop.nix` for environment setup

### 3. Sync Dotfiles

Restore your shell and application configuration:

```bash
./scripts/sync-config pull
```

This syncs:
- zsh config to `~/.config/zsh/zshrc.d/` and `~/.zshrc`
- Neovim config to `~/.config/nvim/`
- Other application configs (starship, tmux, etc.)

Verify:

```bash
ls -la ~/.config/zsh/zshrc.d/
cat ~/.zshrc
```

### 4. Build Configuration

Test the configuration without applying:

```bash
nixos-rebuild dry-run
```

Or with more detail:

```bash
nixos-rebuild dry-build -v
```

### 5. Apply Configuration

Once you're confident:

```bash
sudo nixos-rebuild switch
```

Or apply and keep previous generation available for rollback:

```bash
sudo nixos-rebuild switch --keep-going
```

### 6. Verify Installation

Test that your environment is working:

```bash
# Check shell
zsh
echo $SHELL  # Should be /run/current-system/sw/bin/zsh
exit

# Check key packages
which nvim
which zoxide
which starship

# Check desktop environment (if using Hyprland)
# Log out and select Hyprland at login screen
```

## Testing After Rebuild

Always verify after applying changes:

### System Tests

```bash
# Check package installation
nix-shell -p <package> --run "which <package>"

# Verify services
systemctl status <service>

# Check system state
nixos-option system.stateVersion
```

### Shell Tests

```bash
# Check startup time
time zsh -i -c exit

# Test shell configuration
zsh -i
echo $SHELL
echo $PATH
exit
```

### Desktop Tests (Hyprland)

```bash
# Check Hyprland
hyprctl version

# Check default applications
xdg-mime query default text/html
```

## Troubleshooting Setup

### Build Fails

Check the error message carefully:

```bash
# More verbose output
nixos-rebuild switch --show-trace -vvv
```

### Configuration Doesn't Apply

1. Verify no syntax errors: `nix flake check`
2. Check imports: `grep -r "import" modules/system/`
3. Look for unknown options: `nixos-option system.stateVersion`

### Dotfiles Not Syncing

```bash
# Verify dotfiles exist
ls -la dotfiles/shell/zsh/

# Re-run sync
./scripts/sync-config pull

# Check sync destinations
ls -la ~/.config/zsh/zshrc.d/
```

### Package Not Found After Install

Packages are installed at rebuild time. After `nixos-rebuild switch`:

```bash
which <package>  # Should find it
hash -r          # Clear command cache
which <package>  # Try again
```

## First Time Boot

After `nixos-rebuild switch`, you'll need to:

1. **Reload shell**: Start a new terminal or `exec zsh`
2. **Check environment**: Verify `echo $SHELL` and `echo $PATH`
3. **Test packages**: Use `which` to verify key packages
4. **Log in to desktop**: If using Hyprland, log out and select it from login screen

## Next Steps

- See [MAINTENANCE.md](MAINTENANCE.md) to learn how to edit configuration
- Review [ARCHITECTURE.md](ARCHITECTURE.md) to understand the design
- Check specific tool documentation in [docs/](.) as needed

## Getting Help

- Check [ARCHITECTURE.md](ARCHITECTURE.md) for design decisions
- Review [validation.md](validation.md) for testing procedures
- See [rollback-workflow.md](rollback-workflow.md) if you need to undo changes

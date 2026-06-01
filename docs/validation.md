# Post-Merge Validation Checklist

Run these steps after rebuilding to verify all changes work correctly.

## Pre-rebuild checks

```bash
# 1. Syntax and formatting
nix flake check --no-build
nix fmt

# 2. No Thunar references remain
grep -r "thunar" . --exclude-dir=.git --exclude-dir=.direnv
# Expected output: (empty)
```

## Rebuild

```bash
# Dry run to see what will change
./scripts/rebuild --dry-run

# Actual rebuild
./scripts/rebuild

# Reboot
sudo reboot
```

## Desktop environment

```bash
# 1. Verify Hyprland boots
# (Just check you can see the desktop and open apps)

# 2. Check polkit is working
# Try: Super+E to open Dolphin, or use a privileged action
# Should get auth dialog if needed (not errors)
```

## File manager workflows

```bash
# 1. Test Yazi (terminal file manager)
fm
# Navigate with hjkl, w/b for word jump, / for search
# Exit with q
pwd  # Should show the directory you selected in Yazi

# 2. Test Dolphin (GUI file manager)
Super+E
# Should open KDE Dolphin file manager

# 3. Check MIME defaults
xdg-mime query default inode/directory
# Expected: org.kde.dolphin.desktop

xdg-mime query default text/html
# Expected: org.qutebrowser.qutebrowser.desktop
```

## Shell integrations

```bash
# 1. Reload shell to pick up home-manager changes
exec zsh

# 2. Test direnv
cd /tmp
echo 'export TEST_VAR=hello' > .envrc
direnv allow
echo $TEST_VAR  # Should print: hello
direnv deny
echo $TEST_VAR  # Should be empty
cd -

# 3. Test starship prompt
# (Just verify the prompt looks good and renders quickly)

# 4. Test fzf
Ctrl+R              # History search — should fuzzy-find commands
# Type something, should see fzf dropdown

# 5. Test fzf-tab completion
cd /tmp
touch file1.txt file2.txt
cat file<Tab>       # Should show pretty fzf completion menu

# 6. Test Yazi alias
fm                  # Should open Yazi
```

## Performance settings

```bash
# 1. Verify zram swap
zramctl status

# 2. Check VM settings
cat /proc/sys/vm/swappiness
# Expected: 20

cat /proc/sys/vm/vfs_cache_pressure
# Expected: 50

# 3. Boot time analysis (optional)
systemd-analyze blame | head -20
systemd-analyze critical-chain
```

## Dotfile sync

```bash
# Pull all dotfiles into ~/.config
./scripts/sync-dotfiles pull

# Verify Yazi config exists
ls -la ~/.config/yazi/
# Should have: keymap.toml, theme.toml, yazi.toml
```

## Rollback safety

```bash
# Test rollback mechanism
./scripts/rollback

# Verify boot works
sudo reboot

# Check system is on previous generation
nix profile history

# Switch back to latest if needed
sudo nixos-rebuild switch --flake .#nixos-p14s
```

## Summary

If all checks above pass:

- ✅ Hyprland boots and renders correctly
- ✅ File managers (Yazi + Dolphin) work with proper keybinds
- ✅ Shell integrations (direnv, starship, fzf) all functional
- ✅ Default apps are correctly associated
- ✅ Performance tuning is in effect
- ✅ Rollback mechanism works

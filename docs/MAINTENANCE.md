# Maintenance Guide

How to edit, update, and maintain the NixOS configuration.

## Configuration Structure

```
nixos-config/
├── nix/
│   └── packages.nix          # Package definitions and defaults
├── modules/
│   ├── system/               # System-wide configuration
│   │   ├── boot.nix         # Boot configuration
│   │   ├── desktop.nix      # Desktop environment
│   │   ├── hardware.nix     # Hardware configuration
│   │   ├── packages.nix     # Package wiring
│   │   ├── services.nix     # System services
│   │   ├── networking.nix   # Network configuration
│   │   ├── performance.nix  # Performance tuning
│   │   └── users.nix        # User configuration
│   └── home/                 # Home-manager (user) config
│       ├── desktop.nix      # User desktop settings
│       └── shell.nix        # User shell and tools
├── dotfiles/                 # Manual configuration files
│   ├── shell/zsh/           # Zsh configuration
│   ├── editor/              # Editor configs
│   └── ...
└── scripts/
    └── sync-config          # Sync dotfiles script
```

## Adding Packages

### Find the Right Category

Open `nix/packages.nix` and locate the appropriate category:

- **System Utilities**: Core tools like curl, wget, git
- **Terminal & CLI**: Modern CLI tools like bat, eza, fzf
- **Development**: Compilers, LSPs, version managers (gcc, nodejs, python3)
- **GUI Applications**: Desktop apps like Discord, Firefox
- **Desktop Environment**: Themes, cursors, Wayland tools
- **Security & Networking**: Penetration testing and network tools
- **Media & Archives**: Video/audio processing tools
- **Miscellaneous**: Tools that don't fit elsewhere

### Add the Package

1. Open `nix/packages.nix`
2. Find the appropriate category
3. Add your package alphabetically within the list:

```nix
# Example: Adding ripgrep to 'core' category (already there)
core = with pkgs; [
  # ...
  ripgrep        # Search tool
  rsync
  # ...
];
```

4. Test with:

```bash
nix flake check
nixos-rebuild dry-run
```

5. Apply with:

```bash
sudo nixos-rebuild switch
```

## Removing Packages

1. Open `nix/packages.nix`
2. Find and delete the package line
3. Test and apply:

```bash
nixos-rebuild dry-run
sudo nixos-rebuild switch
```

## Updating Shell Configuration

All zsh configuration is in `dotfiles/shell/zsh/`.

### Modular Configuration

The shell uses a split configuration approach:

```
dotfiles/shell/zsh/
├── .zshrc              # Main entrypoint (sources zshrc.d)
└── zshrc.d/
    ├── 00-oh-my-zsh.zsh          # Oh My Zsh setup
    ├── 10-environment.zsh        # Environment variables
    ├── 20-integrations.zsh       # Tool integrations
    ├── 30-aliases.zsh            # Command aliases
    ├── 40-hyprland.zsh           # Hyprland-specific
    └── 50-starship.zsh           # Starship prompt
```

### Editing Shell Configuration

1. **For existing section**: Edit the file directly
   ```bash
   vim dotfiles/shell/zsh/zshrc.d/30-aliases.zsh
   ```

2. **For new configuration**: Create a numbered file
   ```bash
   cat > dotfiles/shell/zsh/zshrc.d/60-custom.zsh << 'EOF'
   # Custom configuration
   export MY_VAR=value
   alias myalias='command'
   EOF
   ```

3. **Sync to home directory**:
   ```bash
   ./scripts/sync-config pull
   ```

4. **Test**:
   ```bash
   zsh -i
   # Verify your changes work
   exit
   ```

5. **Commit**:
   ```bash
   git add dotfiles/shell/zsh/
   git commit -m "shell: add custom configuration"
   ```

## Updating System Modules

System configuration is in `modules/system/`. Each file handles a specific aspect:

### Common Tasks

**Enable/disable a service**: Edit `modules/system/services.nix`

```nix
services.myservice = {
  enable = true;  # or false
  # ... options ...
};
```

**Change hardware settings**: Edit `modules/system/hardware.nix`

```nix
hardware.enableAllFirmware = true;
```

**Update networking**: Edit `modules/system/networking.nix`

```nix
networking.hostName = "new-hostname";
```

**Modify desktop environment**: Edit `modules/system/desktop.nix`

```nix
programs.hyprland = {
  enable = true;
  xwayland.enable = true;
};
```

### Test and Apply

After editing:

```bash
# Dry-run test
nixos-rebuild dry-run

# Apply
sudo nixos-rebuild switch

# Verify
# Test the changed component
```

## Updating Home-Manager Configuration

User configuration is in `modules/home/`. This includes shell tools, environment variables, and user programs.

### Edit User Configuration

1. Open `modules/home/shell.nix` or `modules/home/desktop.nix`
2. Make your changes (e.g., add environment variables)
3. Rebuild:

```bash
sudo nixos-rebuild switch
```

Changes apply to your user on next shell/login.

## Syncing Dotfiles

Use the `sync-config` script to keep dotfiles synchronized:

### Pull (dotfiles → home directory)

```bash
./scripts/sync-config pull
```

Copies from `dotfiles/` to `~/.config`, `~`, etc.

### Push (home directory → dotfiles)

```bash
./scripts/sync-config push
```

Copies changes back to `dotfiles/` (useful for testing and version control).

### Adding New Dotfiles

1. Place file in `dotfiles/` following the structure
2. Add sync pair to `scripts/sync-config`
3. Run `./scripts/sync-config pull`
4. Commit:

```bash
git add scripts/sync-config dotfiles/...
git commit -m "config: add new dotfile"
```

See [../scripts/README.md](../scripts/README.md) for details.

## Testing Changes

Always test before committing:

### Build Test

```bash
nixos-rebuild dry-run
```

### Configuration Check

```bash
nix flake check
```

### Shell Test

```bash
# For shell changes
./scripts/sync-config pull
zsh -i
# Test your changes
exit
```

### Package Test

```bash
# Verify package builds
nix-build '<nixpkgs>' -A <package>

# Verify it runs
# After nixos-rebuild switch
which <package>
<package> --version
```

## Rollback Changes

If something breaks:

### Recent Changes

```bash
# Show recent generations
sudo nixos-rebuild list-generations

# Switch to previous generation
sudo nixos-rebuild switch --rollback
```

### Find a Specific Generation

```bash
sudo nix-env -p /nix/var/nix/profiles/system --list-generations
sudo nix-env -p /nix/var/nix/profiles/system --switch-generation <number>
```

See [rollback-workflow.md](rollback-workflow.md) for detailed recovery procedures.

## Performance Debugging

If system is slow:

1. Check [OPTIMISATIONS.md](OPTIMISATIONS.md) for tuning options
2. Profile startup:
   ```bash
   time zsh -i -c exit
   zsh -x -i -c exit 2>&1 | head -50
   ```
3. Check services:
   ```bash
   systemctl status  # Overview
   ```
4. Review [performance-improvements.md](performance-improvements.md)

## Common Workflows

### Adding a New Development Tool

1. Search nixpkgs: https://search.nixos.org/packages
2. Add to appropriate category in `nix/packages.nix`
3. Rebuild: `sudo nixos-rebuild switch`
4. Test: `which <tool> && <tool> --version`

### Updating Zsh Aliases

1. Edit `dotfiles/shell/zsh/zshrc.d/30-aliases.zsh`
2. Sync: `./scripts/sync-config pull`
3. Test: `zsh -i` then test alias
4. Commit: `git add dotfiles/ && git commit -m "shell: update aliases"`

### Customizing Desktop Environment

1. Hyprland config: `dotfiles/desktop/hyprland/`
2. Themes: Edit `modules/system/desktop.nix`
3. Sync and rebuild: `./scripts/sync-config pull && sudo nixos-rebuild switch`

## Getting Help

- Review the specific module or config file
- Check [ARCHITECTURE.md](ARCHITECTURE.md) for design rationale
- See [validation.md](validation.md) for testing procedures
- Reference [../scripts/README.md](../scripts/README.md) for sync script details
- Check [../dotfiles/README.md](../dotfiles/README.md) for dotfiles structure

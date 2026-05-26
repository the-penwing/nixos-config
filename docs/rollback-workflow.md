# Rollback & Generation Management

NixOS keeps multiple generations (system configurations) by default, allowing safe rollback.

## Quick rollback after a bad rebuild

```bash
# Rollback to previous generation and reboot
./scripts/rollback
sudo reboot
```

On boot, the previous system configuration will be active.

## View available generations

```bash
# List all generations with timestamps
nix profile history

# Or (older style):
sudo nix-env --list-generations -p /nix/var/nix/profiles/system
```

## Boot from a specific generation (advanced)

At the GRUB boot menu (hold Shift during boot):

1. Select “Advanced options”
2. Choose a previous generation’s kernel/system
3. Boot

NixOS keeps the last 5 generations by default.

## Clean up old generations

```bash
# Delete generations older than 7 days
sudo nix-collect-garbage --delete-older-than 7d

# Full cleanup: keep only current + 1 previous
sudo nix-collect-garbage -d
```

Settings are in `hosts/nixos-t14s/configuration.nix`:

```nix
nix.gc = {
  automatic = true;
  dates = "*-*-* 10:00:00";
  options = "--delete-older-than 7d";
};
```

## Nix store optimisation

NixOS automatically deduplicates store files. Monitor with:

```bash
du -sh /nix/store
nix path-info -Sh /run/current-system
```

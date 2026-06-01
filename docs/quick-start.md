# Quick start

```bash
# Full system rebuild (system + home)
sudo nixos-rebuild switch --flake .#nixos-p14s

# Evaluate flake outputs without building
nix flake check --no-build

# Enter the default dev shell for repo work
nix develop .#default

# Optional manual GC (matches configured policy)
sudo nix-collect-garbage --delete-older-than 2d
```

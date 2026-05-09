# Quick start

```bash
# Full system rebuild (system + home)
sudo nixos-rebuild switch --flake .#nixos-t14s

# Evaluate flake outputs without building
nix flake check --no-build

# One-time manual Nix generation cleanup (keep newest 30)
nix-collect-garbage --delete-generations +30 && nix-collect-garbage -d
```

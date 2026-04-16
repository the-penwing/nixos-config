# Quick start

```bash
# Full system rebuild (system + home)
sudo nixos-rebuild switch --flake .#nixos-laptop

# Home-manager only (no sudo required)
home-manager switch --flake .#nixos-laptop

# One-time manual Nix generation cleanup (keep newest 30)
nix-collect-garbage --delete-generations +30 && nix-collect-garbage -d
```

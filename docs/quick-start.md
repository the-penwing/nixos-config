# Quick start

```bash
# Full system rebuild (system + home)
sudo nixos-rebuild switch --flake .#nixos-laptop

# Home-manager only (no sudo required)
home-manager switch --flake .#nixos-laptop
```

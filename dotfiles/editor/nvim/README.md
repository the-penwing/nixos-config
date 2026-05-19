# Neovim (AstroNvim) configuration

This directory contains the AstroNvim v6 configuration used by this NixOS setup. It is synced into `~/.config/nvim` via `scripts/sync-dotfiles.sh`.

## Install/sync

Back up any existing Neovim config:

```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

Sync from this repo into your home directory:

```bash
./scripts/sync-dotfiles.sh pull
```

Then launch Neovim to bootstrap plugins:

```bash
nvim
```

## Updating

Edit files in this repo, then push your local `~/.config` changes back if needed:

```bash
./scripts/sync-dotfiles.sh push
```

The plugin lockfile is `lazy-lock.json`.

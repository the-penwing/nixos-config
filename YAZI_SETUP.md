# Yazi Setup Guide

## Why Yazi

Use Yazi when you want fast, keyboard-only file navigation in terminal workflows (especially while coding in Neovim).

## Installed components

From `packages.nix`:
- `yazi`
- `ffmpegthumbnailer`
- `mediainfo`
- `poppler_utils`
- `p7zip`
- `unar`
- `ripgrep`, `fd`, `fzf`

## Config files

- `dotfiles/apps/yazi/yazi.toml`
- `dotfiles/apps/yazi/keymap.toml`
- `dotfiles/apps/yazi/theme.toml`

Synced by:

```bash
./scripts/sync-dotfiles pull
```

## Keybindings

- `h` → parent directory
- `l` → enter directory/open
- `w` → forward jump helper
- `b` → backward jump helper
- `/` → smart search

## Shell integration (cd on exit)

`dotfiles/shell/zsh/zshrc.d/20-integrations.zsh` defines:

- `yy()` function: launches yazi and updates shell cwd using `--cwd-file`
- `fm` alias: shortcut to `yy`

## Dolphin fallback

Use Dolphin for GUI-heavy operations:
- drag/drop workflows
- plugin-driven actions (compression/git integrations)
- multi-pane visual file operations

## Test checklist

1. `fm` opens Yazi.
2. Enter a directory in Yazi, quit, and confirm shell cwd changed.
3. Press `Super+E` and confirm Dolphin opens.
4. Open a directory from a GUI app and confirm Dolphin handles it.

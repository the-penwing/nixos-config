#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Define sync pairs: (dotfiles_path, config_path)
declare -a SYNC_PAIRS=(
  "dotfiles/editor/nvim:~/.config/nvim"
  "dotfiles/desktop/hyprland:~/.config/hypr"
  "dotfiles/desktop/waybar:~/.config/waybar"
  "dotfiles/desktop/wofi:~/.config/wofi"
  "dotfiles/desktop/rofi:~/.config/rofi"
  "dotfiles/apps/ghostty:~/.config/ghostty"
  "dotfiles/apps/btop:~/.config/btop"
  "dotfiles/apps/fastfetch:~/.config/fastfetch"
  "dotfiles/apps/waypaper:~/.config/waypaper"
  "dotfiles/apps/lazygit:~/.config/lazygit"
  "dotfiles/shell/zsh/.zshrc:~/.zshrc"
  "dotfiles/shell/tmux/.tmux.conf:~/.tmux.conf"
  "dotfiles/theme/gtk-3.0:~/.config/gtk-3.0"
  "dotfiles/theme/dunst:~/.config/dunst"
)

ACTION="${1:-pull}"

sync_pair() {
  local src="$1"
  local dst="$2"
  
  # Expand ~ to actual home
  dst="${dst/#\~/$HOME}"
  
  # Make src absolute
  src="${REPO_ROOT}/${src}"
  
  # Skip if source doesn't exist
  if [ ! -e "$src" ]; then
    echo "  ⚠️  Source does not exist: $src"
    return
  fi
  
  if [ "$ACTION" = "pull" ]; then
    # dotfiles → ~/.config (repo is source of truth, but preserve local files)
    mkdir -p "$(dirname "$dst")"
    echo "  ← $src"
    rsync -av "$src/" "$dst/" 2>/dev/null || true
    chmod -R u+w "$dst" 2>/dev/null || true
  elif [ "$ACTION" = "push" ]; then
    # ~/.config → dotfiles (save your edits back)
    if [ ! -e "$dst" ]; then
      echo "  ⚠️  Destination does not exist: $dst"
      return
    fi
    mkdir -p "$(dirname "$src")"
    echo "  → $dst"
    rsync -av --delete "$dst/" "$src/" 2>/dev/null || true
  fi
}

echo "=== Config Sync: $ACTION ==="
for pair in "${SYNC_PAIRS[@]}"; do
  IFS=: read -r src dst <<< "$pair"
  sync_pair "$src" "$dst"
done

echo "✅ Sync complete"

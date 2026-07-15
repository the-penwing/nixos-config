# ============================================================================
# Aliases: Repository Management
# ============================================================================
alias update-repo-dotfiles='~/nixos-config/scripts/sync-dotfiles push'
alias update-home-dotfiles='~/nixos-config/scripts/sync-dotfiles pull'
alias rebuild='~/nixos-config/scripts/rebuild'
alias rollback-system='~/nixos-config/scripts/rollback'

# ============================================================================
# Aliases: Python & Tools
# ============================================================================
alias python3='python3.14'
alias python='python3.14'
alias pip='uv pip'
alias evil-winrm='evil-winrm-py'
alias tree-no-docs='tree --gitignore -I "*.md" --prune'
alias czb='cargo zigbuild'
alias czbr='cargo zigbuild --release'
alias ns="nix-search-tv print | fzf \
  --preview 'nix-search-tv preview {}' \
  --scheme history"
alias nso="nix-search-tv print | fzf \
  --preview 'nix-search-tv preview {}' \
  --bind 'enter:execute(nix-search-tv preview {})+accept'"
alias sesh-fzf='sesh connect "$(sesh list | fzf)"'

# ============================================================================
# Aliases: Modern CLI Tool Replacements
# ============================================================================
alias ls='eza'
alias ll='eza --icons -l'
alias la='eza --icons -la'
alias du='dust'
alias df='duf'
alias cd='z'
alias cdi='zi'
alias fm='yy'

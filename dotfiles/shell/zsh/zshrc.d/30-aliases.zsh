# ============================================================================
# Aliases: Repository Management
# ============================================================================
alias update-repo-dotfiles='~/nixos-config/scripts/sync-dotfiles.sh push'
alias update-home-dotfiles='~/nixos-config/scripts/sync-dotfiles.sh pull'


# ============================================================================
# Aliases: Python & Tools
# ============================================================================
alias python3='python3.14'
alias python='python3.14'
alias pip='uv pip'
alias evil-winrm='evil-winrm-py'

# ============================================================================
# Aliases: Power Management
# ============================================================================
alias tlp-perf='sudo tlp ac'
alias tlp-save='sudo tlp bat'


# ============================================================================
# Aliases: Modern CLI Tool Replacements
# ============================================================================
# (interactive shell only — use \cmd to call the original)
alias cat='bat'
alias ls='eza'
alias ll='eza --icons -l'
alias la='eza --icons -la'
alias grep='rg'
alias find='fd'
alias du='dust'
alias df='duf'
alias ps='btop'
alias cd='z'
alias cdi='zi'

# ============================================================================
# Direnv Lazy-Load + Zoxide Initialization
# ============================================================================

# Wrap cd to lazy-load direnv only when entering a direnv-managed directory
cd() {
  builtin cd "$@" || return
  
  if [[ -f .envrc || -f .env ]]; then
    eval "$(direnv hook zsh)"
    unfunction cd
    direnv reload
  fi
}

# Initialize zoxide (provides z/zi aliases)
eval "$(zoxide init zsh)"

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

function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    zle reset-prompt > /dev/null 2>&1 || true
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}

zle     -N             sesh-sessions
bindkey -M emacs '\es' sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions

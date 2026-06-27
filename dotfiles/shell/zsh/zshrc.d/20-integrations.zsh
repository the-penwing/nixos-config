# ============================================================================
# Integrations: fzf, yazi, zoxide and direnv
# ============================================================================

# FZF shell integration (safe to source even if already loaded by plugin)
[[ -f "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"

# FZF-tab styling
zstyle ':fzf-tab:*' fzf-flags --color=dark --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7 --style default
zstyle ':fzf-tab:*' fzf-min-height 6

# Yazi shell integration: change shell cwd to the directory selected in yazi
yy() {
  local tmp cwd
  tmp="$(mktemp -t yazi-cwd.XXXXXX)"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat "$tmp")" && [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
    cd "$cwd"
  fi
  rm -f "$tmp"
}

eval "$(direnv hook zsh)"
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

# ============================================================================
# Integrations: fzf, yazi, zoxide, direnv, sesh
# ============================================================================

ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"

# FZF shell integration
source <(fzf --zsh)

# FZF-tab styling
zstyle ':fzf-tab:*' fzf-flags --color=dark --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7 --style default
zstyle ':fzf-tab:*' fzf-min-height 6

# Yazi: file manager with cwd sync
yy() {
  local tmp cwd
  tmp="$(mktemp -t yazi-cwd.XXXXXX)"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat "$tmp")" && [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
    cd "$cwd"
  fi
  rm -f "$tmp"
}

# direnv: load/unload environment based on .envrc
eval "$(direnv hook zsh)"

# zoxide: smart directory jumper (replaces cd)
eval "$(zoxide init zsh)"

# sesh: terminal session switcher (Alt+S)
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

zle -N sesh-sessions
bindkey -M emacs '\es' sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions

# Partial History
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
[[ -n "${terminfo[kcuu1]}" ]] && bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
[[ -n "${terminfo[kcud1]}" ]] && bindkey "${terminfo[kcud1]}" down-line-or-beginning-search

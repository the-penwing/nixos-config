# Force Emacs mode early so plugins/configs don't put us in Vi mode
bindkey -e
# Fix the Delete key producing a tilde
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char

# sesh: terminal session switcher (Alt+S)
function sesh-sessions() {
	local session
	session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
	zle reset-prompt >/dev/null 2>&1 || true

	if [[ -n "$session" ]]; then
		exec </dev/tty
		exec <&1
		sesh connect "$session"
	fi
}

zle -N sesh-sessions
bindkey -M emacs '\es' sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions

# ==============================================================================
# Partial History
# ==============================================================================
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Force terminal to send terminfo application sequences
function zle-line-init() {
    [[ -n ${terminfo[smkx]} ]] && echoti smkx
}
function zle-line-finish() {
    [[ -n ${terminfo[rmkx]} ]] && echoti rmkx
}
zle -N zle-line-init
zle -N zle-line-finish

# Comprehensive key bindings covering terminfo and common fallback strings
if [[ -n "${terminfo[kcuu1]}" ]]; then
    bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
if [[ -n "${terminfo[kcud1]}" ]]; then
    bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# Hardcoded fallback bindings for SSH, Termux, and standard emulators
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[OA' up-line-or-beginning-search
bindkey '\e[A' up-line-or-beginning-search

bindkey '^[[B' down-line-or-beginning-search
bindkey '^[OB' down-line-or-beginning-search
bindkey '\e[B' down-line-or-beginning-search

# Ensure clean exit status for sourcing
true

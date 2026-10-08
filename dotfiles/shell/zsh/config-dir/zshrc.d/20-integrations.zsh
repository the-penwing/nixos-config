# Fix the Delete key producing a tilde
bindkey "^[[3~" delete-char

# sesh: terminal session switcher (Alt+S)
function sesh-sessions() {
	local session
	session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
	zle reset-prompt >/dev/null 2>&1

	if [[ -n "$session" ]]; then
		exec </dev/tty
		exec <&1
		sesh connect "$session"
	fi
}
zle -N sesh-sessions
bindkey -M emacs '\es' sesh-sessions

# Partial History
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[OA' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^[OB' down-line-or-beginning-search

# ============================================================================
# Integrations: fzf, yazi, zoxide, direnv, sesh
# ============================================================================

# Force Emacs mode early so plugins/configs don't put us in Vi mode
bindkey -e
# Fix the Delete key producing a tilde
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char

ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p "$CACHE_DIR"

# FZF shell integration (Cached)
if [[ ! -s "$CACHE_DIR/fzf.zsh" || $(command -v fzf) -nt "$CACHE_DIR/fzf.zsh" ]]; then
	fzf --zsh >"$CACHE_DIR/fzf.zsh" 2>/dev/null
fi
source "$CACHE_DIR/fzf.zsh"

# Yazi: file manager with cwd sync
yy() {
	local tmp="$(mktemp)"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat "$tmp")" && [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
		cd "$cwd"
	fi
	rm -f "$tmp"
}

# Colored Man Pages
function man() {
	LESS="-R" \
		MANROFFOPT="-c" \
		LESS_TERMCAP_mb=$'\e[1;31m' \
		LESS_TERMCAP_md=$'\e[1;31m' \
		LESS_TERMCAP_me=$'\e[0m' \
		LESS_TERMCAP_se=$'\e[0m' \
		LESS_TERMCAP_so=$'\e[1;44;33m' \
		LESS_TERMCAP_ue=$'\e[0m' \
		LESS_TERMCAP_us=$'\e[1;32m' \
		command man "$@"
}

# direnv (Cached)
if [[ ! -s "$CACHE_DIR/direnv.zsh" || $(command -v direnv) -nt "$CACHE_DIR/direnv.zsh" ]]; then
	direnv hook zsh >"$CACHE_DIR/direnv.zsh" 2>/dev/null
fi
source "$CACHE_DIR/direnv.zsh"

# zoxide (Cached)
if [[ ! -s "$CACHE_DIR/zoxide.zsh" || $(command -v zoxide) -nt "$CACHE_DIR/zoxide.zsh" ]]; then
	zoxide init zsh >"$CACHE_DIR/zoxide.zsh" 2>/dev/null
fi
source "$CACHE_DIR/zoxide.zsh"

# sesh: terminal session switcher (Alt+S)
function sesh-sessions() {
	local session
	session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
	zle reset-prompt >/dev/null 2>&1 || true

	if [[ -n "$session" ]]; then
		# Restore TTY control before connecting to the tmux session
		exec </dev/tty
		exec <&1
		sesh connect "$session"
	fi
}

zle -N sesh-sessions
bindkey -M emacs '\es' sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions

# ============================================================================
# Partial History (Keep at the absolute bottom so it overrides everything else)
# ============================================================================
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Try terminfo keys first, fallback to standard ANSI codes if empty
if [[ -n "${terminfo[kcuu1]}" ]]; then
	bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
else
	bindkey '^[[A' up-line-or-beginning-search
	bindkey '^[OA' up-line-or-beginning-search
fi

if [[ -n "${terminfo[kcud1]}" ]]; then
	bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
else
	bindkey '^[[B' down-line-or-beginning-search
	bindkey '^[OB' down-line-or-beginning-search
fi

update-zsh-plugins() {
	for d in ~/.config/zsh/plugins/*/.git; do
		local dir="$(dirname "$d")"
		echo "Updating $(basename "$dir")..."
		git -C "$dir" pull
	done
	echo "All plugins updated!"
}

# Ensure clean exit status for sourcing
true

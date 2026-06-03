# ============================================================================
# Environment Variables
# ============================================================================
set -a

# PATH Configuration
PATH="$HOME/.local/bin:$PATH"
PATH="$PATH:$HOME/.npm-global/bin"
PATH="$PATH:$HOME/.cargo/bin"

npm_config_prefix="~/.npm-global"
SUDO_EDITOR="nvim"
EDITOR="nvim"
MANPAGER="less"
GROFF_NO_SGR="1"
FZF_BASE="~/.fzf/"
FZF_DEFAULT_COMMAND="fd"
DISABLE_FZF_AUTO_COMPLETION="true"
DISABLE_FZF_KEY_BINDINGS="false"
FZF_DEFAULT_OPTS="--color=dark --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7 --style full --preview 'bat --style=numbers --color=always --line-range :500 {}'"
SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent"
GPG_TTY=$(tty)
TIMEFMT=$'\nreal %*E\nuser %*U\nsys %*S\n'
BAT_THEME="Dracula"
DOCKER_HOST=unix:///run/user/1000/podman/podman.sock

set +a

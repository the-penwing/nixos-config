# ============================================================================
# Oh My Zsh Configuration
# ============================================================================
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""
ENABLE_CORRECTION="true"

plugins=(
    zsh-autosuggestions
    git
    zsh-syntax-highlighting
    fzf
    zsh-interactive-cd
)

source $ZSH/oh-my-zsh.sh


# ============================================================================
# Environment Variables
# ============================================================================
set -a

# PATH Configuration
PATH="$HOME/.local/bin:$PATH"
PATH="$PATH:$HOME/.npm-global/bin"
PATH="$PATH:$HOME/.cargo/bin"

# Editor Configuration
SUDO_EDITOR=$(which nvim)
EDITOR=$(which nvim)

# Pager Configuration (man pages & less)
MANPAGER='less'
GROFF_NO_SGR=1

# Colorise man pages
LESS_TERMCAP_mb=$'\e[1;31m'
LESS_TERMCAP_md=$'\e[1;31m'
LESS_TERMCAP_me=$'\e[0m'
LESS_TERMCAP_se=$'\e[0m'
LESS_TERMCAP_so=$'\e[1;33;44m'
LESS_TERMCAP_ue=$'\e[0m'
LESS_TERMCAP_us=$'\e[4;1;32m'
LESS_TERMCAP_mr=$'\e[7m'
LESS_TERMCAP_mh=$'\e[2m'
LESS_TERMCAP_ZN=$'\e[74m'
LESS_TERMCAP_ZV=$'\e[75m'
LESS_TERMCAP_ZO=$'\e[73m'
LESS_TERMCAP_ZW=$'\e[75m'

# fzf Configuration
FZF_BASE=~/.fzf/
FZF_DEFAULT_COMMAND='fd'
DISABLE_FZF_AUTO_COMPLETION="false"
DISABLE_FZF_KEY_BINDINGS="false"

# SSH & XDG
SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent"

# Make the time command look better
TIMEFMT=$'\nreal %E\nuser %U\nsys %S\n'

set +a


# ============================================================================
# Shell Integrations
# ============================================================================
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


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


# ============================================================================
# Aliases: Power Management
# ============================================================================
alias tlp-perf='sudo tlp ac'
alias tlp-save='sudo tlp bat'


# ============================================================================
# Aliases: Modern CLI Tool Replacements
# ============================================================================
# (interactive shell only — use \cmd to call the original)
alias cat='bat --paging=never'
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


# ============================================================================
# Auto-start Hyprland
# ============================================================================
if [[ -z $WAYLAND_DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
  exec start-hyprland
fi

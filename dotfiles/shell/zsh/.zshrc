# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

#ZSH_THEME="classyTouch"
ZSH_THEME=""

ENABLE_CORRECTION="true"

plugins=( 
    zsh-autosuggestions
    git
    zsh-syntax-highlighting
    fzf
    zsh-interactive-cd
)
export PATH="$HOME/.local/bin:$PATH"


export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent"

eval "$(direnv hook zsh)"

# Node (global via NixOS)
export PATH="$PATH:$HOME/.npm-global/bin"

# Rust/Cargo (via NixOS rustup)
export PATH="$PATH:$HOME/.cargo/bin"

# NeoVim (installed via NixOS packages)
export SUDO_EDITOR=$(which nvim)
export EDITOR=$(which nvim)

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_BASE=~/.fzf/
export FZF_DEFAULT_COMMAND='fd'
DISABLE_FZF_AUTO_COMPLETION="false"
DISABLE_FZF_KEY_BINDINGS="false"

# Starship 
eval "$(starship init zsh)"

# oh-my-zsh — must be near end
source $ZSH/oh-my-zsh.sh

alias python3='python3.14'
alias python='python3.14'
alias pip='uv pip'
alias tlp-perf='sudo tlp ac'
alias tlp-save='sudo tlp bat'

# Better CLI tools (interactive shell only — use \cmd to call the original)
alias cat='bat --paging=never'
alias ls='eza'
alias ll='eza --icons -l'
alias la='eza --icons -la'
alias grep='rg'
alias find='fd'
alias du='dust'
alias df='duf'
alias ps='btop'

# Auto-start Hyprland on TTY1 login (interactive shell only)
if [[ -z $WAYLAND_DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
  exec start-hyprland
fi

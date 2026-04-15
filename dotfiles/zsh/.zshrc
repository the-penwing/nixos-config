# ============================================================
# ZSH Configuration
# ============================================================

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme — disabled in favour of Starship prompt
ZSH_THEME=""

# ============================================================
# Oh My Zsh plugins
# ============================================================
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  docker
  npm
  rust
)

source $ZSH/oh-my-zsh.sh

# ============================================================
# Starship prompt
# ============================================================
eval "$(starship init zsh)"

# ============================================================
# Environment variables
# ============================================================

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
if [[ -d $PYENV_ROOT/bin ]]; then
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

# npm global prefix
export PATH="$HOME/.npm-global/bin:$PATH"

# Rust / Cargo
export PATH="$HOME/.cargo/bin:$PATH"

# ============================================================
# Aliases
# ============================================================
alias ls='ls --color=auto'
alias ll='ls -lah'
alias la='ls -a'
alias grep='grep --color=auto'

# Git
alias lg='lazygit'
alias g='git'

# NixOS
alias nrs='sudo nixos-rebuild switch --flake ~/nixos-config#default'
alias nrb='sudo nixos-rebuild boot --flake ~/nixos-config#default'
alias hms='home-manager switch --flake ~/nixos-config#default'

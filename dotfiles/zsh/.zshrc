# Oh My Zsh configuration

export ZSH="${HOME}/.oh-my-zsh"

# Plugins
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    fzf
    zsh-interactive-cd
    direnv
)

# Colors
export TERM=xterm-256color
ZSH_THEME="gruvbox-ls"

# Paths
export NODE_PATH="$(npm root -g)"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.local/bin"

# Editor
export EDITOR="nvim"

# FZF configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Starship prompt init
eval "$(starship init zsh)"

# Python and Pip aliases
alias python3='python3.14'
alias python='python3.14'
alias pip='uv pip'
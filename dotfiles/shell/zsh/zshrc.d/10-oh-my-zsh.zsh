# ============================================================================
# Oh My Zsh Configuration — Full Framework
# ============================================================================
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

plugins=(
    git
    rust
    fzf
    fzf-tab
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-cargo-completion
)
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

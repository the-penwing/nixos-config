# ============================================================================
# Oh My Zsh Configuration — Full Framework
# ============================================================================
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

plugins=(
    git
    fzf
    fzf-tab
    zsh-autosuggestions
    zsh-syntax-highlighting
    rust
    zsh-cargo-completion
)

source $ZSH/oh-my-zsh.sh

# ============================================================================
# Oh My Zsh Configuration — Full Framework
# ============================================================================
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""
ENABLE_CORRECTION="true"

plugins=(
    git
    fzf
    fzf-tab
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

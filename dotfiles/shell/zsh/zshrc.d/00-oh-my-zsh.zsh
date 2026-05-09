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

# ============================================================================
# Oh My Zsh Configuration - Full Framework
# ============================================================================
export ZSH="$HOME/.oh-my-zsh"

plugins=(
    # Comp
    git
    rust
    custom-comp

    # QOL
    fzf
    fzf-tab
    zsh-autosuggestions
    zsh-syntax-highlighting
)

compdef _cargo cargo-zigbuild

source $ZSH/oh-my-zsh.sh

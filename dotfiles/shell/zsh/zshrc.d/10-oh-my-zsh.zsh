# ============================================================================
# Oh My Zsh Configuration - Full Framework
# ============================================================================
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

plugins=(
    # Compleations
    git
    rust
    zsh-cargo-completion
    zig-shell-completions
    custom-comp

    # QOL
    fzf
    fzf-tab
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

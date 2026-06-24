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
    zig-shell-completions
    custom-comp
)

source $ZSH/oh-my-zsh.sh

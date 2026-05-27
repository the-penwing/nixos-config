# Modular zsh entrypoint
# Split by concern under ~/.config/zsh/zshrc.d.

for zshrc_part in ~/.config/zsh/zshrc.d/*.zsh; do
  [ -r "$zshrc_part" ] && source "$zshrc_part"
done
export XDG_DATA_DIRS="$HOME/.local/share:$XDG_DATA_DIRS"

# ============================================================================
# Oh My Zsh Configuration
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

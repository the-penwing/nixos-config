# ============================================================================
# Zsh Syntax Highlighting
# ============================================================================

ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"
PLUGIN_DIR="$ZDOTDIR/plugins"

if [[ -f "$PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
	source "$PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Ensure clean exit status for sourcing
true

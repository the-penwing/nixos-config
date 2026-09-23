# ============================================================================
# Starship Prompt (Cached)
# ============================================================================

CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p "$CACHE_DIR"

if [[ ! -s "$CACHE_DIR/starship.zsh" || $(command -v starship) -nt "$CACHE_DIR/starship.zsh" ]]; then
	starship init zsh >"$CACHE_DIR/starship.zsh" 2>/dev/null
fi
source "$CACHE_DIR/starship.zsh"

# Ensure clean exit status for sourcing
true

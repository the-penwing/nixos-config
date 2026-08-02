# ============================================================================
# Plugins & Custom Completion Paths
# ============================================================================

ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"
PLUGIN_DIR="$ZDOTDIR/plugins"

# Add completion directories to fpath BEFORE compinit runs
fpath=(
	"$PLUGIN_DIR/custom-comp"
	"$PLUGIN_DIR/zsh-completions/src"
	$fpath
)

# Source interactive UI & suggestion plugins
if [[ -f "$PLUGIN_DIR/fzf-tab/fzf-tab.plugin.zsh" ]]; then
	source "$PLUGIN_DIR/fzf-tab/fzf-tab.plugin.zsh"
	zstyle ':fzf-tab:*' fzf-flags --color=dark '--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f' '--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7' --style default
	zstyle ':fzf-tab:*' fzf-min-height 6
fi

if [[ -f "$PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
	source "$PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
	ZSH_AUTOSUGGEST_STRATEGY=(history completion)
	ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
fi

# Ensure clean exit status for sourcing
true

# ============================================================================
# Lazy-load heavy plugins
# ============================================================================

ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"
PLUGIN_DIR="$ZDOTDIR/plugins"


# fzf-tab: lazy-load on first Tab press
if [[ -f "$PLUGIN_DIR/fzf-tab/fzf-tab.plugin.zsh" ]]; then
  source "$PLUGIN_DIR/fzf-tab/fzf-tab.plugin.zsh"    
  # Apply styling
  zstyle ':fzf-tab:*' fzf-flags --color=dark --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7 --style default
  zstyle ':fzf-tab:*' fzf-min-height 6
fi

# zsh-syntax-highlighting: load early (affects every keystroke)
if [[ -f "$PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# zsh-autosuggestions: load early (completion suggestions on every keystroke)
if [[ -f "$PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
fi

# zsh-completions plugin: load early (adds more completion sources)
if [[ -f "$PLUGIN_DIR/zsh-completions/zsh-completions.plugin.zsh" ]]; then
  source "$PLUGIN_DIR/zsh-completions/zsh-completions.plugin.zsh"
fi

# custom-comp: load early (your custom completions)
if [[ -f "$PLUGIN_DIR/custom-comp/custom-comp.plugin.zsh" ]]; then
  source "$PLUGIN_DIR/custom-comp/custom-comp.plugin.zsh"
fi

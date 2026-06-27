# ============================================================================
# Zsh Completion System (No OMZ)
# ============================================================================
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qNmh+24) ]]; then
  compinit
else
  compinit -C
fi

autoload -Uz bashcompinit && bashcompinit

# Add fpath for completions
ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"
fpath=(
  $ZDOTDIR/plugins/custom-comp
  $ZDOTDIR/plugins/zsh-completions/src
  $fpath
)

# Rebuild completion cache
if [[ -n ${ZDOTDIR}/.zcompdump(#qNmh+24) ]]; then
  compinit -C
fi

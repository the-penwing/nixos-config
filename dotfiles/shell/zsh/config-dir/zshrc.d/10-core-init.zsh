# ============================================================================
# Zsh Completion System (No OMZ)
# ============================================================================
ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"
fpath=(
  "$ZDOTDIR/plugins/custom-comp"
  "$ZDOTDIR/plugins/zsh-completions/src"
  $fpath
)

autoload -Uz compinit bashcompinit

setopt extendedglob
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qNmh+24) ]]; then
  compinit
else
  compinit -C
fi

bashcompinit

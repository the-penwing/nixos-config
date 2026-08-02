# ============================================================================
# Zsh Completion Initialization (Fast Dump Check)
# ============================================================================
autoload -Uz compinit bashcompinit

ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"
ZCOMPDUMP="$ZDOTDIR/.zcompdump"

# mh-24 = modified LESS than 24 hours ago (use cached -C)
setopt extendedglob
if [[ -s "$ZCOMPDUMP" && -n "$ZCOMPDUMP"(#qNmh-24) ]]; then
    # Cache is fresh (< 24h); skip directory audit
    compinit -C -d "$ZCOMPDUMP"
else
    # Cache is stale (> 24h) or missing; rebuild dump file
    compinit -d "$ZCOMPDUMP"
fi

bashcompinit

# Ensure clean exit status for sourcing
true

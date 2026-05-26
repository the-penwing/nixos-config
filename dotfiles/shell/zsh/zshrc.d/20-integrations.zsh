# ============================================================================
# Integrations: custom shell extensions and tools
# ============================================================================

# Yazi shell integration: change shell cwd to the directory selected in yazi.
yy() {
  local tmp cwd
  tmp="$(mktemp -t yazi-cwd.XXXXXX)"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd "$cwd"
  fi
  rm -f "$tmp"
}

# Modular zsh entrypoint
# Split by concern under ~/.config/zsh/zshrc.d.

for zshrc_part in ~/.config/zsh/zshrc.d/*.zsh; do
  [ -r "$zshrc_part" ] && source "$zshrc_part"
done

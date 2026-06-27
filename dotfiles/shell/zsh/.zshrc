# Modular zsh entrypoint
for zshrc_part in ~/.config/zsh/zshrc.d/*.zsh; do
  [ -r "$zshrc_part" ] && source "$zshrc_part"
done

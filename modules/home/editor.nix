{ config, pkgs, ... }:

{
  # Initial setup: copy nvim configs to ~/.config/nvim on first run
  home.activation.setupNvimConfig = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    nvim_config="$HOME/.config/nvim"
    mkdir -p "$nvim_config"
    
    # Copy from dotfiles (repo is source of truth, preserve local files)
    ${pkgs.rsync}/bin/rsync -av \
      ${../../dotfiles/editor/nvim}/ \
      "$nvim_config/"
    
    # Make editable
    chmod -R u+w "$nvim_config"
  '';
}

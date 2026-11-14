{...}: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
    stdlib = ''
      direnv_layout_dir() {
        echo "$HOME/.cache/direnv/layouts/''${PWD//\//_}"
      }
    '';
  };
}

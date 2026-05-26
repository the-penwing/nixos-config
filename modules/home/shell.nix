# Home shell/developer ergonomics module.
#
# Purpose:
# - Keep per-user shell tooling and environment variables together
# - Keep SSH agent behaviour explicit and auditable
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    lazygit
    sassc
  ];

  home.sessionPath = [
    "$HOME/.npm-global/bin"
  ];

  home.file.".npmrc".text = ''
    prefix=$HOME/.npm-global
  '';

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*" = {
      addKeysToAgent = "yes";
      identityFile = "~/.ssh/id_ed25519";
    };
  };

  home.sessionVariables = {
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";
  };

  programs.zsh.initExtra = ''
    ${pkgs.openssh}/bin/ssh-add ${config.home.homeDirectory}/.ssh/id_ed25519 2>/dev/null &
  '';
}

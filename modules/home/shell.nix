{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    nodejs
    python3
    pkg-config
    gcc
    gnumake
    rustup
    sassc
    lazygit
    tea
    pyenv
    uv
    zoxide
  ];

  home.sessionPath = [
    "$HOME/.npm-global/bin"
  ];

  home.file.".npmrc".text = ''
    prefix=$HOME/.npm-global
  '';

  # Copy shell configs from dotfiles (repo is source of truth)

  # SSH - Cache key passphrases via ssh-agent
  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      addKeysToAgent = "yes";
      identityFile = "${config.home.homeDirectory}/.ssh/id_ed25519";
    };
  };

  home.sessionVariables = {
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";
  };

  programs.zsh.initExtra = ''
    # Load SSH key into agent on shell startup
    ${pkgs.openssh}/bin/ssh-add ${config.home.homeDirectory}/.ssh/id_ed25519 2>/dev/null &
  '';
}

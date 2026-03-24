{ config, pkgs, ... }:

{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    nodejs
    python3
    pkg-config
    gcc
    gnumake
  ];

  home.sessionPath = [
    "${config.home.homeDirectory}/.npm-global/bin"
  ];

  home.file.".npmrc".text = ''
    prefix=${config.home.homeDirectory}/.npm-global
  '';
}

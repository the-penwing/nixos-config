{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system
  ];

  # ============================================================
  # NIX SETTINGS
  # ============================================================
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.optimise = {
  	automatic = true;
  	dates = "*-*-* 10:00:00";
  };
  nix.gc = {
  	automatic = true;
  	dates = "*-*-* 10:00:00";
    options = "--delete-older-than 2d";
  };
  security.pki.certificateFiles = [ ./secrets/root.crt ];

  # ============================================================
  # DO NOT CHANGE
  # ============================================================
  system.stateVersion = "25.11";
}

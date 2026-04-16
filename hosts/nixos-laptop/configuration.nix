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
  nix.gc.automatic = true;
  # systemd calendar syntax: run every Sunday at 03:00
  nix.gc.dates = "Sun *-*-* 03:00:00";
  nix.gc.options = "--delete-generations +30";

  security.pki.certificateFiles = [ ./secrets/root.crt ];

  # ============================================================
  # DO NOT CHANGE
  # ============================================================
  system.stateVersion = "25.11";
}

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/boot.nix
    ../../modules/system/networking.nix
    ../../modules/system/hardware.nix
    ../../modules/system/services.nix
    ../../modules/system/packages.nix
    ../../modules/system/input.nix
  ];

  # ============================================================
  # NIX SETTINGS
  # ============================================================
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  security.pki.certificateFiles = [ ./secrets/root.crt ];

  # ============================================================
  # DO NOT CHANGE
  # ============================================================
  system.stateVersion = "25.11";
}

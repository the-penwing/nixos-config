# Desktop environment and default application behaviour.
#
# Dependencies:
# - ../../nix/packages.nix for MIME defaults and app desktop IDs
#
# Customisation notes:
# - Keep default app handlers in packages.nix so package choices and handlers stay aligned.
{
  pkgs,
  inputs,
  lib,
  ...
}: let
  packageSet = import ./package-list.nix {inherit pkgs lib;};
in {
  services.xserver.enable = false;
  services.xserver.xkb = {
    layout = "au";
    variant = "";
  };

  services.getty.autologinUser = "benvl";

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };

  # Privilege escalation and privileged action authentication.
  security.polkit.enable = true;

  xdg.mime.defaultApplications = packageSet.mimeDefaults;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config.common.default = ["hyprland" "gtk"];
  };
}

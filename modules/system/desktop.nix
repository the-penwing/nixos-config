# Desktop environment and default application behaviour.
#
# Dependencies:
# - ../../nix/packages.nix for MIME defaults and app desktop IDs
#
# Customisation notes:
# - Keep default app handlers in packages.nix so package choices and handlers stay aligned.
{
  pkgs,
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
    xwayland.enable = true;
  };
  systemd.user.targets.hyprland-session = {
    description = "Hyprland compositor session";
    bindsTo = ["graphical-session.target"];
    wants = ["graphical-session-pre.target"];
    after = ["graphical-session-pre.target"];
  };

  # Privilege escalation and privileged action authentication.
  security.polkit.enable = true;

  xdg.mime.defaultApplications = packageSet.mimeDefaults;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    config.common.default = ["hyprland" "gtk"];
  };
}

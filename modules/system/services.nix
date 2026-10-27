# System services and daemon lifecycle.
#
# Purpose:
# - Keep service declarations readable
# - Prefer socket activation/on-demand startup where practical
{
  pkgs,
  lib,
  ...
}: {
  documentation = {
    enable = true;
    man = {
      man-db.enable = false;
      mandoc.enable = true;
      generateCaches = true;
    };
    dev.enable = true;
    info.enable = true;
    doc.enable = true;
  };

  services.tailscale.enable = true;
  services.dbus.enable = true;

  services.syncthing = {
    enable = true;
    user = "benvl";
    dataDir = "/home/benvl/.local/share/syncthing";
    openDefaultPorts = true;
  };

  services.upower.enable = true;

  services.gvfs.enable = true;

  services.udisks2.enable = true;

  services.udev.packages = [pkgs.udiskie];

  services.pcscd = {
    enable = true;
    plugins = [pkgs.ccid];
  };

  services.printing = {
    enable = true;
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.locate = {
    enable = true;
    package = pkgs.plocate;
  };

  services.flatpak.enable = true;
}

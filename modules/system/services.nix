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
    man.enable = true;
    dev.enable = true;
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

  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd;
  };

  services.udisks2.enable = true;

  services.udev.packages = [pkgs.udiskie];

  services.pcscd = {
    enable = true;
    plugins = [pkgs.ccid];
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      brlaser
      cups-browsed
      cups-filters
    ];
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

# System services and daemon lifecycle.
#
# Purpose:
# - Keep service declarations readable
# - Prefer socket activation/on-demand startup where practical
{ pkgs, lib, ... }:

{
  services.tailscale.enable = true;
  services.dbus.enable = true;
  services.solaar = {
    enable = true;
    package = pkgs.solaar;
    window = "hide";
    batteryIcons = "regular";
    extraArgs = "";
  };

  services.syncthing = {
    enable = true;
    user = "benvl";
    dataDir = "/home/benvl/.local/share/syncthing";
    openDefaultPorts = true;
  };
  # Start syncthing only when explicitly triggered.
  systemd.services.syncthing.wantedBy = lib.mkForce [ ];

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
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

  programs.direnv.enable = true;
  programs.firefox.enable = true;
  programs.nix-ld.enable = true;
  programs.thunderbird.enable = true;
  programs.zoxide.enable = true;
  programs.zsh.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;
}

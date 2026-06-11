# System services and daemon lifecycle.
#
# Purpose:
# - Keep service declarations readable
# - Prefer socket activation/on-demand startup where practical
{ pkgs, lib, ... }:

{
  # ============================================================
  # Socket Activation Policy
  # ============================================================
  # Services listed below use systemd socket activation:
  # - podman.socket (activates Podman on first podman/act command)
  # - syncthing (explicitly not in boot targets — manual start only)
  # - printing (CUPS) — activates on first print job
  # - avahi — multicast DNS discovery on demand
  # ============================================================

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

  systemd.services.rclone-mount = {
    description = "Auto Mount Rclone iCloud Drive";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    requires = [ "network-online.target" ];

    serviceConfig = {
      Type = "simple";

      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p /home/benvl/icloud/";
      ExecStart = "${pkgs.rclone}/bin/rclone mount iCloud:my-files/ /home/benvl/icloud/ --file-perms=0777 --vfs-cache-mode=full --umask=0000 --allow-other";
      ExecStop = "${pkgs.fuse}/bin/fusermount -uz /home/benvl/icloud/";

      Restart = "on-failure";
      RestartSec = "10s";
      User = "benvl";
      Group = "benvl";

      Enviroment = [ "PATH=/run/wrappers/bin/:$PATH"];
    };
  };
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

  programs.firefox.enable = true;
  programs.nix-ld.enable = true;
  programs.thunderbird.enable = true;
  programs.zoxide.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses; # Forces a TTY prompt that works safely in the background
  };

  programs.zsh = {
    enable = true;
  };

  virtualisation.podman = {
    enable = true;
    dockerSocket.enable = true;
  };
}

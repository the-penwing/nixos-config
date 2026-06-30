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
  systemd.services.syncthing.wantedBy = lib.mkForce [];

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  systemd.services.rclone-mount = {
    description = "Auto Mount Rclone iCloud Drive";
    wantedBy = ["multi-user.target"];
    after = ["network-online.target"];
    requires = ["network-online.target"];

    serviceConfig = {
      Type = "simple";

      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p /home/benvl/icloud/";
      ExecStart = "${pkgs.rclone}/bin/rclone mount iCloud:my-files/ /home/benvl/icloud/ --file-perms=0777 --vfs-cache-mode=full --umask=0000 --dir-cache-time=1m --attr-timeout 1m";
      ExecStopPost = "${pkgs.bash}/bin/bash -c '${pkgs.fuse3}/bin/fusermount3 -uz /home/benvl/icloud/ 2>/dev/null; ${pkgs.coreutils}/bin/rm -rf /home/benvl/icloud/'";

      Restart = "on-failure";
      RestartSec = "10s";
      User = "benvl";
      Group = "benvl";

      Environment = ["PATH=/run/wrappers/bin/:$PATH"];

      PrivateDevices = false;
      PrivateTmp = false;
    };
  };

  systemd.services.tmux-server = {
    description = "Auto start tmux server on boot";
    wantedBy = ["default.target"];
    serviceConfig = {
      Type = "forking";

      ExecStart = "${pkgs.tmux}/bin/tmux start-server";

      Restart = "on-failure";
      RestartSec = "2s";
      User = "benvl";
      Group = "benvl";

      Environment = ["PATH=/run/wrappers/bin/:$PATH"];

      PrivateDevices = false;
      PrivateTmp = false;
    };
  };

  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  services.pcscd = {
    enable = true;
    plugins = [pkgs.ccid];
  };

  # Add PIN caching for OpenSC
  environment.etc."opensc/opensc.conf".text = ''
    app default {
      # Enable PIN caching
      pin_cache_type = "user";
      pin_cache_ignore_user_consent = false;

      # 5-minute PIN cache timeout
      pin_cache_min_lifetime = 300;
      pin_cache_max_lifetime = 300;
    }
  '';

  systemd.tmpfiles.rules = [
    "d /var/lib/pcsc 0755 pcscd pcscd - -"
    "d /var/lib/pcsc/drivers 0755 pcscd pcscd - -"
    "L /var/lib/pcsc/drivers/ifd-ccid.bundle - - - - ${pkgs.ccid}/pcsc/drivers/ifd-ccid.bundle"
  ];

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

  programs.firefox.enable = true;
  programs.thunderbird.enable = true;

  programs.nix-ld.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  virtualisation.podman = {
    enable = true;
    dockerSocket.enable = true;
  };

  programs.zsh = {
    enable = true;
  };
}

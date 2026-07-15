{
  pkgs,
  lib,
  ...
}: {
  # Only start syncthing when explicitly requested
  systemd.services.syncthing.wantedBy = lib.mkForce [];

  # Auto Mount iCloud
  systemd.services.icloud = {
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

  # Auto Mount Self-Hosted Nextcloud
  systemd.services.nextcloud = {
    description = "Auto Mount Rclone Nextcloud";
    wantedBy = ["multi-user.target"];
    after = ["network-online.target"];
    requires = ["network-online.target"];

    serviceConfig = {
      Type = "simple";

      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p /home/benvl/nextcloud/";
      ExecStart = "${pkgs.rclone}/bin/rclone mount nextcloud: /home/benvl/nextcloud/ --file-perms=0777 --vfs-cache-mode=full --umask=0000 --dir-cache-time=1m --attr-timeout 1m";
      ExecStopPost = "${pkgs.bash}/bin/bash -c '${pkgs.fuse3}/bin/fusermount3 -uz /home/benvl/nextcloud/ 2>/dev/null; ${pkgs.coreutils}/bin/rm -rf /home/benvl/nextcloud/'";

      Restart = "on-failure";
      RestartSec = "10s";
      User = "benvl";
      Group = "benvl";

      Environment = ["PATH=/run/wrappers/bin/:$PATH"];

      PrivateDevices = false;
      PrivateTmp = false;
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/pcsc 0755 pcscd pcscd - -"
    "d /var/lib/pcsc/drivers 0755 pcscd pcscd - -"
    "L /var/lib/pcsc/drivers/ifd-ccid.bundle - - - - ${pkgs.ccid}/pcsc/drivers/ifd-ccid.bundle"
  ];
}

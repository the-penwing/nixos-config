{pkgs, ...}: {
  # Auto Mount iCloud
  systemd.user.services.icloud = {
    description = "Auto Mount Rclone iCloud Drive";
    wantedBy = ["default.target"];
    after = ["network-online.target"];

    serviceConfig = {
      Type = "simple";

      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/icloud/";
      ExecStart = "${pkgs.rclone}/bin/rclone mount iCloud:my-files/ %h/icloud/ --file-perms=0777 --vfs-cache-mode=full --umask=0000 --dir-cache-time=1m --attr-timeout 1m";
      ExecStopPost = "${pkgs.bash}/bin/bash -c '${pkgs.fuse3}/bin/fusermount3 -uz %h/icloud/ 2>/dev/null; ${pkgs.coreutils}/bin/rm -rf %h/icloud/'";

      Restart = "on-failure";
      RestartSec = "10s";

      Environment = ["PATH=/run/wrappers/bin/:$PATH"];

      PrivateDevices = false;
      PrivateTmp = false;
    };
  };

  # Auto Mount Self-Hosted Nextcloud
  systemd.user.services.nextcloud = {
    description = "Auto Mount Rclone Nextcloud";
    wantedBy = ["default.target"];
    after = ["network-online.target"];

    serviceConfig = {
      Type = "simple";

      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/nextcloud/";
      ExecStart = "${pkgs.rclone}/bin/rclone mount nextcloud: %h/nextcloud/ --file-perms=0777 --vfs-cache-mode=full --umask=0000 --dir-cache-time=1m --attr-timeout 1m";
      ExecStopPost = "${pkgs.bash}/bin/bash -c '${pkgs.fuse3}/bin/fusermount3 -uz %h/nextcloud/ 2>/dev/null; ${pkgs.coreutils}/bin/rm -rf %h/nextcloud/'";

      Restart = "on-failure";
      RestartSec = "10s";

      Environment = ["PATH=/run/wrappers/bin/:$PATH"];

      PrivateDevices = false;
      PrivateTmp = false;
    };
  };
}

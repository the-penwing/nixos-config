{pkgs, ...}: {
  # Auto Mount Self-Hosted Nextcloud
  systemd.user.services.nextcloud = {
    Unit = {
      Description = "Auto Mount Rclone Nextcloud";
      After = ["network-online.target"];
    };

    Install = {
      WantedBy = ["default.target"];
    };

    Service = {
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

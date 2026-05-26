# Home desktop module.
#
# Purpose:
# - Keep user-level desktop helpers and user services in one place
# - Avoid duplicate package declarations already managed system-wide
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mpris-scrobbler
  ];

  systemd.user.services.mpris-scrobbler = {
    Unit = {
      Description = "mpris-scrobbler - ListenBrainz scrobbler via MPRIS";
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.mpris-scrobbler}/bin/mpris-scrobbler";
      Restart = "on-failure";
      RestartSec = 5;
    };
    Install.WantedBy = [ "default.target" ];
  };
}

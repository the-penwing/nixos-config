{ config, pkgs, ... }:

{
  # ============================================================
  # PACKAGES
  # ============================================================
  home.packages = with pkgs; [
    # Desktop helpers used alongside Caelestia
    mpris-scrobbler
    # Assuming caelestia-shell is available via overlays or nix-community/nix-index
    # If not, you may need to add: inputs.caelestia.packages.${system}.default
  ];

  # ============================================================
  # SYSTEMD USER SERVICES
  # ============================================================
  systemd.user.services = {
    mpris-scrobbler = {
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
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}

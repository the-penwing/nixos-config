{ config, pkgs, ... }:

{
  # ============================================================
  # PACKAGES
  # ============================================================
  home.packages = with pkgs; [
    # Removed waybar, added caelestia dependencies
    brightnessctl
    playerctl
    mpris-scrobbler
    # Assuming caelestia-shell is available via overlays or nix-community/nix-index
    # If not, you may need to add: inputs.caelestia.packages.${system}.default
  ];

  # # ============================================================
  # # PROGRAMS / CONFIGS
  # # ============================================================
  # # Caelestia shell configuration
  # programs.caelestia = {
  #   enable = true;
  #   systemd = {
  #     enable = true;
  #     target = "graphical-session.target";
  #   };
  #   settings = {
  #     # Custom shell.json settings
  #     bar.status = {
  #       showBattery = true;
  #     };
  #   };
  #   cli = {
  #     enable = true;
  #   };
  # };
  #
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

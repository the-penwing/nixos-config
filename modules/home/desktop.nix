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

  # ============================================================
  # PROGRAMS / CONFIGS
  # ============================================================
  # Caelestia shell configuration
  programs.caelestia = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
    settings = {
      # Custom shell.json settings
      bar.status = {
        showBattery = true;
      };
    };
    cli = {
      enable = true;
    };
  };

  # Activation script for dotfiles
  home.activation.setupDesktopConfigs = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    # Remove waybar from here
    for dir in hypr ghostty; do
      config_dir="$HOME/.config/$dir"
      mkdir -p "$config_dir"
      
      ${pkgs.rsync}/bin/rsync -av \
        ${../../dotfiles/desktop}/$dir/ \
        "$config_dir/" 2>/dev/null || true
      
      chmod -R u+w "$config_dir"
    done
    
    # Theme configs (keep these)
    for theme_dir in gtk-3.0 dunst; do
      config_dir="$HOME/.config/$theme_dir"
      mkdir -p "$config_dir"
      
      ${pkgs.rsync}/bin/rsync -av \
        ${../../dotfiles/theme}/$theme_dir/ \
        "$config_dir/" 2>/dev/null || true
      
      chmod -R u+w "$config_dir"
    done
    
    # App configs (keep these)
    for app_dir in btop fastfetch waypaper; do
      config_dir="$HOME/.config/$app_dir"
      mkdir -p "$config_dir"
      
      ${pkgs.rsync}/bin/rsync -av \
        ${../../dotfiles/apps}/$app_dir/ \
        "$config_dir/" 2>/dev/null || true
      
      chmod -R u+w "$config_dir"
    done
  '';

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

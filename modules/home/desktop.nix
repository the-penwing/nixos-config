{ config, pkgs, ... }:

{
  # Initial setup: copy desktop configs on first run
  home.activation.setupDesktopConfigs = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    for dir in hypr waybar wofi rofi ghostty; do
      config_dir="$HOME/.config/$dir"
      mkdir -p "$config_dir"
      
      ${pkgs.rsync}/bin/rsync -av \
        ${../../dotfiles/desktop}/$dir/ \
        "$config_dir/" 2>/dev/null || true
      
      chmod -R u+w "$config_dir"
    done
    
    # Theme configs
    for theme_dir in gtk-3.0 dunst; do
      config_dir="$HOME/.config/$theme_dir"
      mkdir -p "$config_dir"
      
      ${pkgs.rsync}/bin/rsync -av \
        ${../../dotfiles/theme}/$theme_dir/ \
        "$config_dir/" 2>/dev/null || true
      
      chmod -R u+w "$config_dir"
    done
    
    # App configs
    for app_dir in btop fastfetch waypaper lazygit; do
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
  home.packages = [ pkgs.mpris-scrobbler ];

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

{ pkgs, turntable, ... }:

{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    nodejs
    python3
    pkg-config
    gcc
    gnumake
  ];

  home.sessionPath = [
    "$HOME/.npm-global/bin"
  ];

  home.file.".npmrc".text = ''
    prefix=$HOME/.npm-global
  '';

  # ============================================================
  # XDG CONFIG FILES
  # Drop all Hyprland config files via home-manager
  # ============================================================

  xdg.configFile."hypr/hyprland.conf".source = ./dotfiles/hypr/hyprland.conf;
  xdg.configFile."hypr/hyprpaper.conf".source = ./dotfiles/hypr/hyprpaper.conf;
  xdg.configFile."hypr/hyprlock.conf".source = ./dotfiles/hypr/hyprlock.conf;
  xdg.configFile."hypr/hypridle.conf".source = ./dotfiles/hypr/hypridle.conf;

  xdg.configFile."waybar/config.jsonc".source = ./dotfiles/waybar/config.jsonc;
  xdg.configFile."waybar/style.css".source   = ./dotfiles/waybar/style.css;

  xdg.configFile."wofi/style.css".source = ./dotfiles/wofi/style.css;
  xdg.configFile."wofi/config".source    = ./dotfiles/wofi/config;

  xdg.configFile."dunst/dunstrc".source = ./dotfiles/dunst/dunstrc;

  xdg.configFile."wlogout/style.css".source = ./dotfiles/wlogout/style.css;

  xdg.configFile."ghostty/config".source = ./dotfiles/ghostty/config;

  xdg.configFile."gtk-3.0/settings.ini".source = ./dotfiles/gtk-3.0/settings.ini;

  # ============================================================
  # SYSTEMD USER SERVICES (Turntable scrobblers — unchanged)
  # ============================================================
  systemd.user.services = {
    turntable-naviterm = {
      Unit = {
        Description = "Turntable scrobbler - naviterm";
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "simple";
        ExecStart = "${turntable}/bin/dev.geopjr.Turntable --headless --client=org.mpris.MediaPlayer2.naviterm";
        Restart = "on-failure";
        RestartSec = 5;
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };

    turntable-vlc = {
      Unit = {
        Description = "Turntable scrobbler - VLC";
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "simple";
        ExecStart = "${turntable}/bin/dev.geopjr.Turntable --headless --client=org.mpris.MediaPlayer2.vlc";
        Restart = "on-failure";
        RestartSec = 5;
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}

{ turntable, ... }:

{
  # Hyprland - Wayland Compositor
  xdg.configFile."hypr/hyprland.conf".source = ../../dotfiles/desktop/hyprland/hyprland.conf;
  xdg.configFile."hypr/hyprpaper.conf".source = ../../dotfiles/desktop/hyprland/hyprpaper.conf;
  xdg.configFile."hypr/hyprlock.conf".source = ../../dotfiles/desktop/hyprland/hyprlock.conf;
  xdg.configFile."hypr/hypridle.conf".source = ../../dotfiles/desktop/hyprland/hypridle.conf;

  # Waybar - Status Bar
  xdg.configFile."waybar/config.jsonc".source = ../../dotfiles/desktop/waybar/config.jsonc;
  xdg.configFile."waybar/style.css".source   = ../../dotfiles/desktop/waybar/style.css;

  # Wofi - Application Launcher
  xdg.configFile."wofi/style.css".source = ../../dotfiles/desktop/wofi/style.css;
  xdg.configFile."wofi/config".source    = ../../dotfiles/desktop/wofi/config;

  # Dunst - Notification Daemon
  xdg.configFile."dunst/dunstrc".source = ../../dotfiles/theme/dunst/dunstrc;

  # Wlogout - Session Management
  xdg.configFile."wlogout/style.css".source = ../../dotfiles/desktop/wlogout/style.css;

  # Ghostty - Terminal Emulator
  xdg.configFile."ghostty/config".source = ../../dotfiles/apps/ghostty/config;

  # GTK - GUI Toolkit Theme
  xdg.configFile."gtk-3.0/settings.ini".source = ../../dotfiles/theme/gtk-3.0/settings.ini;

  # NetworkManager Dmenu - Network Control
  xdg.configFile."networkmanager-dmenu/config.ini".source = ../../dotfiles/apps/networkmanager-dmenu/config.ini;

  # Rofi - Application Launcher & Menu
  xdg.configFile."rofi/config.rasi".source = ../../dotfiles/desktop/rofi/config.rasi;

  # Fastfetch - System Information
  xdg.configFile."fastfetch/config.jsonc".source = ../../dotfiles/apps/fastfetch/config.jsonc;

  # Waypaper - Wallpaper Manager
  xdg.configFile."waypaper/config.ini".source = ../../dotfiles/apps/waypaper/config.ini;

  # Btop - System Monitor
  xdg.configFile."btop/btop.conf".source = ../../dotfiles/apps/btop/btop.conf;

  # ============================================================
  # SYSTEMD USER SERVICES (Turntable scrobblers)
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

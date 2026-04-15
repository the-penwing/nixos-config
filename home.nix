{ pkgs, turntable, ... }:

{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    nodejs
    python3
    pkg-config
    gcc
    gnumake
    rustup
    sassc
    lazygit
    tea
    pyenv
    uv
  ];

  home.sessionPath = [
    "$HOME/.npm-global/bin"
  ];

  home.file.".npmrc".text = ''
    prefix=$HOME/.npm-global
  '';

  # ============================================================
  # XDG CONFIG FILES
  # Drop all dotfiles via home-manager symlinks
  # ============================================================

  # Hyprland - Wayland Compositor
  xdg.configFile."hypr/hyprland.conf".source = ./dotfiles/hypr/hyprland.conf;
  xdg.configFile."hypr/hyprpaper.conf".source = ./dotfiles/hypr/hyprpaper.conf;
  xdg.configFile."hypr/hyprlock.conf".source = ./dotfiles/hypr/hyprlock.conf;
  xdg.configFile."hypr/hypridle.conf".source = ./dotfiles/hypr/hypridle.conf;

  # Waybar - Status Bar
  xdg.configFile."waybar/config.jsonc".source = ./dotfiles/waybar/config.jsonc;
  xdg.configFile."waybar/style.css".source   = ./dotfiles/waybar/style.css;

  # Wofi - Application Launcher
  xdg.configFile."wofi/style.css".source = ./dotfiles/wofi/style.css;
  xdg.configFile."wofi/config".source    = ./dotfiles/wofi/config;

  # Dunst - Notification Daemon
  xdg.configFile."dunst/dunstrc".source = ./dotfiles/dunst/dunstrc;

  # Wlogout - Session Management
  xdg.configFile."wlogout/style.css".source = ./dotfiles/wlogout/style.css;

  # Ghostty - Terminal Emulator
  xdg.configFile."ghostty/config".source = ./dotfiles/ghostty/config;

  # GTK - GUI Toolkit Theme
  xdg.configFile."gtk-3.0/settings.ini".source = ./dotfiles/gtk-3.0/settings.ini;

  # NetworkManager Dmenu - Network Control
  xdg.configFile."networkmanager-dmenu/config.ini".source = ./dotfiles/networkmanager-dmenu/config.ini;

  # Rofi - Application Launcher & Menu
  xdg.configFile."rofi/config.rasi".source = ./dotfiles/rofi/config.rasi;

  # Starship - Shell Prompt
  xdg.configFile."starship.toml".source = ./dotfiles/starship.toml;

  # Fastfetch - System Information
  xdg.configFile."fastfetch/config.jsonc".source = ./dotfiles/fastfetch/config.jsonc;

  # Btop - System Monitor
  xdg.configFile."btop/btop.conf".source = ./dotfiles/btop/btop.conf;

  # ============================================================
  # HOME FILES (not in XDG .config)
  # ============================================================

  # Zsh - Shell Configuration
  home.file.".zshrc".source = ./dotfiles/zsh/.zshrc;

  # Tmux - Terminal Multiplexer
  home.file.".tmux.conf".source = ./dotfiles/tmux/.tmux.conf;

  # ============================================================
  # NEOVIM CONFIG
  # ============================================================
  xdg.configFile."nvim/init.lua".source = ./dotfiles/nvim/init.lua;
  xdg.configFile."nvim/lazyvim.json".source = ./dotfiles/nvim/lazyvim.json;
  xdg.configFile."nvim/lazy-lock.json".source = ./dotfiles/nvim/lazy-lock.json;
  xdg.configFile."nvim/stylua.toml".source = ./dotfiles/nvim/stylua.toml;
  xdg.configFile."nvim/lua".source = ./dotfiles/nvim/lua;

  
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

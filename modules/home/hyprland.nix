{...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    configType = "lua";
    systemd.enable = false;
    extraLuaFiles."config" = ../../dotfiles/desktop/hyprland/config.lua;
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 900;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      wallpaper = [
        {
          monitor = "";
          path = "${../../dotfiles/desktop/wallpaper/dracula-nixos.png}";
          fit_mode = "cover";
        }
      ];
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
      };
      background = [
        {
          monitor = "";
          path = "${../../dotfiles/desktop/wallpaper/dracula-nixos.png}";
          blur_passes = 2;
        }
      ];
      input-field = [
        {
          monitor = "";
          size = "300, 50";
          outline_thickness = 2;
          dots_size = 0.25;
          dots_spacing = 0.3;
          outer_color = "rgb(189, 147, 249)";
          inner_color = "rgb(68, 71, 90)";
          font_color = "rgb(248, 248, 242)";
          check_color = "rgb(139, 233, 253)";
          fail_color = "rgb(255, 85, 85)";
          placeholder_text = "";
          position = "0, -20";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        {
          monitor = "";
          text = "$TIME";
          color = "rgb(248, 248, 242)";
          font_size = 64;
          position = "0, 120";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}

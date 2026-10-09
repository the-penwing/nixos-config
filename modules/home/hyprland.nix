{...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    configType = "lua";
    systemd.enable = false;
    extraLuaFiles."config" = ../../dotfiles/desktop/hyprland/config.lua;
  };

  xdg.configFile."hypr/hyprpaper.conf".source = ../../dotfiles/desktop/hyprland/hyprpaper.conf;
}

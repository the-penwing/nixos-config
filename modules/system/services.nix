{ pkgs, ... }:

{
  # ============================================================
  # DESKTOP — Hyprland is primary, LightDM as login manager
  # ============================================================
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    xkb = {
      layout = "au";
      variant = "";
    };
  };

  # Hyprland (Wayland)
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Hyprlock & Hypridle — declarative
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  # XDG desktop portals
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    config.common.default = [ "hyprland" "gtk" ];
  };

  # ============================================================
  # SERVICES
  # ============================================================
  services.tailscale.enable = true;
  services.flatpak.enable = true;
  programs.thunderbird.enable = true;
  services.dbus.enable = true;
  services.solaar = {
    enable = true;
    package = pkgs.solaar;
    window = "hide";
    batteryIcons = "regular";
    extraArgs = "";
  };
  services.syncthing = {
    enable = true;
    user = "benvl";
    dataDir = "/home/benvl/.local/share/syncthing";
    openDefaultPorts = true;
  };
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
    };
  };

  # Polkit (needed for auth dialogs in Hyprland)
  security.polkit.enable = true;

  # usbmuxd iOS compatibility
  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  services.tlp.enable = true;

  # ============================================================
  # PROGRAMS
  # ============================================================
  programs.firefox.enable = true;
  programs.zsh.enable = true;

  # ============================================================
  # VIRTUALISATION
  # ============================================================
  virtualisation.docker.enable = true;

  programs.nix-ld.enable = true;
}

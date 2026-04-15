{ pkgs, lib, ... }:

{
  # ============================================================
  # DESKTOP — Hyprland is primary, TTY autologin (no display manager)
  # ============================================================
  # X11 server disabled — Wayland only
  # (XWayland enabled via Hyprland for app compatibility)
  services.xserver.enable = false;

  # Keyboard layout — applies system-wide (console + Wayland)
  services.xserver.xkb = {
    layout = "au";
    variant = "";
  };

  # Automatic TTY login — Hyprland is started from .zshrc on TTY1
  services.getty.autologinUser = "benvl";

  # Hyprland (Wayland)
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Hyprlock & Hypridle — declarative
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  # XDG desktop portals — Hyprland portal only (Wayland-only setup)
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
    ];
    config.common.default = [ "hyprland" ];
  };

  # ============================================================
  # SERVICES
  # ============================================================
  services.tailscale.enable = true;
  programs.thunderbird.enable = true;
  services.dbus.enable = true;
  services.solaar = {
    enable = true;
    package = pkgs.solaar;
    window = "hide";
    batteryIcons = "regular";
    extraArgs = "";
  };
  # Socket-activate syncthing — starts on demand, not at boot
  services.syncthing = {
    enable = true;
    user = "benvl";
    dataDir = "/home/benvl/.local/share/syncthing";
    openDefaultPorts = true;
  };
  # Remove syncthing from boot targets so it only starts when manually triggered
  systemd.services.syncthing.wantedBy = lib.mkForce [ ];

  # Polkit (needed for auth dialogs in Hyprland)
  security.polkit.enable = true;

  # usbmuxd iOS compatibility
  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  services.tlp.enable = true;

  # Printing (CUPS) — socket activated, loads on first print job
  services.printing.enable = true;

  # ============================================================
  # PROGRAMS
  # ============================================================
  programs.firefox.enable = true;
  programs.zsh.enable = true;

  # ============================================================
  # VIRTUALISATION
  # ============================================================
  # Docker — socket activated, starts on first docker command
  virtualisation.docker.enable = true;
  # Disable docker daemon at boot; docker.socket activates it on demand
  virtualisation.docker.enableOnBoot = false;

  programs.nix-ld.enable = true;
}

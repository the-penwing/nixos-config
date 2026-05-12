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

  # Idle/lock handling is provided by Caelestia

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
  
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  # Polkit (needed for auth dialogs in Hyprland)
  security.polkit.enable = true;

  # usbmuxd iOS compatibility
  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  # Printing (CUPS) — socket activated, loads on first print job
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
    ];
  };

  # Enable automatic discovery of printers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # ============================================================
  # PROGRAMS
  # ============================================================
  programs.direnv.enable = true;
  programs.firefox.enable = true;
  programs.zoxide.enable = true;
  programs.zsh = {
    enable = true;
  };

  # ============================================================
  # VIRTUALISATION
  # ============================================================
  # Docker — socket activated, starts on first docker command
  virtualisation.docker.enable = true;
  # Disable docker daemon at boot; docker.socket activates it on demand
  virtualisation.docker.enableOnBoot = false;
  # QEMU/KVM for virtual machines
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.runAsRoot = false;

  programs.nix-ld.enable = true;

}

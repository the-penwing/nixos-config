# ============================================================================
# Environment Variables — Safe declarative environment mapping
# ============================================================================
{pkgs, ...}: {
  environment.localBinInPath = true;

  environment.sessionVariables = {
    # Preferred Default Editors
    EDITOR = "hx";
    SUDO_EDITOR = "hx";

    # Graphics overrides for Hashcat and Wayland / Hyprland mapping
    RUSTICL_ENABLE = "radeonsi";
    AMD_DEBUG = "asym_alloc";
    NIXOS_OZONE_WL = "1";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";

    # Development runtime tracking
    npm_config_prefix = "$HOME/.npm-global";
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";
    DOCKER_HOST = "unix:///run/user/1000/podman/podman.sock";

    # GTK / System Themes schema indexing
    GSETTINGS_SCHEMA_DIR = "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/glib-2.0/schemas";
  };
}

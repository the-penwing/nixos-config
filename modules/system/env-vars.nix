{ pkgs, ... }:

{
  environment.variables = {
    PATH = "$HOME/.local/bin:$PATH:$HOME/.npm-global/bin:$HOME/.cargo/bin:$HOME/nixos-config/scripts";
    npm_config_prefix = "$HOME/.npm-global";
    SUDO_EDITOR = "nvim";
    EDITOR = "nvim";
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";
    GPG_TTY = "$(tty)";
    DOCKER_HOST = "unix:///run/user/1000/podman/podman.sock";
    GSETTINGS_SCHEMA_DIR = "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/glib-2.0/schemas";
  };
}

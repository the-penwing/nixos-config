# Home desktop module.
#
# Purpose:
# - Keep user-level desktop helpers and user services in one place
# - Avoid duplicate package declarations already managed system-wide
{
  pkgs,
  inputs,
  ...
}: {
  home.file.".config/hypr/.luarc.json" = {
    text = builtins.toJSON {
      workspace = {
        library = [
          "${inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland}/share/hypr/stubs"
        ];
      };
      diagnostics = {
        globals = ["hl"];
      };
    };
  };

  services.wluma = {
    enable = true;
    systemd = {
      enable = true;
      target = "default.target";
    };
    settings = {
      als = {
        none = {};
      };
      capturer = "wayland";
      output = {
        backlight = [
          {
            name = "eDP-1";
            path = "/sys/class/backlight/amdgpu_bl1";
          }
        ];
      };
    };
  };

  home.packages = with pkgs; [
    mpris-scrobbler
  ];

  systemd.user.services.mpris-scrobbler = {
    Unit = {
      Description = "mpris-scrobbler - ListenBrainz scrobbler via MPRIS";
      After = ["graphical-session.target"];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.mpris-scrobbler}/bin/mpris-scrobbler";
      Restart = "on-failure";
      RestartSec = 5;
    };
    Install.WantedBy = ["default.target"];
  };
}

# Home desktop module.
#
# Purpose:
# - Keep user-level desktop helpers and user services in one place
# - Avoid duplicate package declarations already managed system-wide
{
  pkgs,
  lib,
  elephant,
  system,
  ...
}: {
  home.file.".config/hypr/.luarc.json" = {
    text = builtins.toJSON {
      workspace = {
        library = [
          "${pkgs.hyprland}/share/hypr/stubs"
        ];
      };
      diagnostics = {
        globals = ["hl"];
      };
    };
  };

  home.activation.linkElephantProviders = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p $HOME/.config/elephant/providers
    rm -f $HOME/.config/elephant/providers/*.so
    for f in ${elephant.packages.${system}.elephant-with-providers}/lib/elephant/providers/*.so; do
      ln -sf "$f" $HOME/.config/elephant/providers/
    done
  '';

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

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Dracula";
      icon-theme = "Papirus-Dark";
      color-theme = "Bibata-Modern-Classic";
      font-name = "Sans 11";
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

{ pkgs, turntable, ... }:

{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    nodejs
    python3
    pkg-config
    gcc
    gnumake
  ];

  home.sessionPath = [
    "$HOME/.npm-global/bin"
  ];

  home.file.".npmrc".text = ''
    prefix=$HOME/.npm-global
  '';

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

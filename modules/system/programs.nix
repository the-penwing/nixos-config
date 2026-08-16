{
  pkgs,
  lib,
  ...
}: {
  programs.fuse = {
    enable = true;
    userAllowOther = true;
  };

  programs.solaar = {
    enable = true;
    package = pkgs.solaar;
    userService = {
      enable = true;
      window = "hide";
      batteryIcons = "regular";
    };
  };

  programs.firefox = {
    enable = true;
  };
  programs.thunderbird = {
    enable = true;
  };

  programs.nix-ld = {
    enable = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  programs.kdeconnect = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
  };
}

{
  pkgs,
  lib,
  ...
}: {
  programs.fuse = {
    enable = true;
    userAllowOther = true;
  };

  programs.dconf.enable = true;
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Dracula";
      icon-theme = "Papirus-Dark";
      color-theme = "Bibata-Modern-Classic";
      font-name = "Sans 11";
    };
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

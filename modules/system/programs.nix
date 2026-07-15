{
  pkgs,
  lib,
  ...
}: {
  programs.fuse = {
    enable = true;
    userAllowOther = true;
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

  programs.zsh = {
    enable = true;
  };
}

{ pkgs, turntable, ... }:

{
  home.stateVersion = "25.11";

  _module.args.turntable = turntable;

  imports = [
    ./modules/home/shell.nix
    ./modules/home/editor.nix
    ./modules/home/desktop.nix
  ];
}

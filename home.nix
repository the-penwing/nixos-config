{ pkgs, ... }:

{
  home.stateVersion = "25.11";

  imports = [
    ./modules/home/shell.nix
    ./modules/home/editor.nix
    ./modules/home/desktop.nix
  ];
}

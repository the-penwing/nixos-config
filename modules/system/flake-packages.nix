# modules/system/flake-packages.nix
{
  inputs,
  system,
  ...
}: let
  mine = inputs.the-penwing.packages.${system};
in {
  environment.systemPackages = [
    mine.blackjack-slint
    mine.blackjack-rs
    mine.lua-dungeon-crawler

    inputs.walker.packages.${system}.default
    inputs.elephant.packages.${system}.elephant-with-providers
    inputs.naviterm.packages.${system}.default
  ];
}

# modules/system/packages.nix
{
  pkgs,
  lib,
  ...
}: let
  packageSet = import ./package-list.nix {inherit pkgs lib;};
in {
  environment.systemPackages = packageSet.systemPackages;
  fonts.packages = packageSet.fonts;
}

# System package wiring.
#
# Purpose:
# - Pull all package categories from ../../nix/packages.nix
# - Keep the package catalogue as a single source of truth
{ pkgs, lib, ... }:
let
  packageSet = import ../../nix/packages.nix { inherit pkgs lib; };
in
{
  environment.systemPackages = packageSet.systemPackages;
  fonts.packages = packageSet.fonts;
}

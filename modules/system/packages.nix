# System package wiring.
#
# Purpose:
# - Pull all package categories from ../../packages.nix
# - Keep the package catalogue as a single source of truth
{ pkgs, lib, ... }:
let
  packageSet = import ../../packages.nix { inherit pkgs lib; };
in
{
  environment.systemPackages = packageSet.systemPackages;
  fonts.packages = packageSet.fonts;
}

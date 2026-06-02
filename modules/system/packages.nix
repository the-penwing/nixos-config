# System package wiring.
#
# Purpose:
# - Pull all package categories from .package-list.nix
# - Keep the package catalogue as a single source of truth
{ pkgs, lib, ... }:
let
  packageSet = import ./package-list.nix { inherit pkgs lib; };
in
{
  environment.systemPackages = packageSet.systemPackages;
  fonts.packages = packageSet.fonts;
}

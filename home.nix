# Home Manager entrypoint for user benvl.
#
# Purpose:
# - Keep home-manager concerns separate from system modules
# - Compose user shell and desktop modules from ./modules/home
{ pkgs, ... }:

{
  home.stateVersion = "25.11";

  imports = [
    ./modules/home
  ];
}

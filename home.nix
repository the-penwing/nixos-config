# Home Manager entrypoint for user benvl.
#
# Purpose:
# - Keep home-manager concerns separate from system modules
# - Compose user shell and desktop modules from ./modules/home
{
  pkgs,
  elephant,
  system,
  ...
}: {
  home.stateVersion = "25.11";

  imports = [
    ./modules/home
  ];
  _module.args = {inherit elephant system;};
}

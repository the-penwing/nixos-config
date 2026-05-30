# User accounts and group memberships.
#
# Customisation:
# - Add user-specific groups here
# - Keep account metadata separate from package definitions
{ pkgs, ... }:

{
  users.groups.benvl = {};
  users.users.benvl = {
    isNormalUser = true;
    group = "benvl";
    description = "Ben van Leeuwen";
    shell = pkgs.zsh;
    extraGroups = [
      "input"
      "networkmanager"
      "plugdev"
      "plocate"
      "video"
      "wheel"
    ];
  };
}

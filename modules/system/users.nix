# User accounts and group memberships.
#
# Customisation:
# - Add user-specific groups here
# - Keep account metadata separate from package definitions
{ pkgs, ... }:

{
  users.users.benvl = {
    isNormalUser = true;
    description = "Ben van Leeuwen";
    shell = pkgs.zsh;
    extraGroups = [
      "docker"
      "input"
      "networkmanager"
      "plugdev"
      "plocate"
      "video"
      "wheel"
    ];
  };
}

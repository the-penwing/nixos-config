# home.nix
{inputs, ...}: {
  home.stateVersion = "25.11";
  imports = [./modules/home];
}

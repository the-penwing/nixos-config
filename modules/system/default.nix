{ ... }:

{
  imports = [
    ./boot.nix
    ./networking.nix
    ./hardware.nix
    ./services.nix
    ./packages.nix
    ./input.nix
  ];
}

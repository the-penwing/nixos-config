# System module entrypoint.
#
# Purpose:
# - Keep host configuration modular and predictable
# - Separate desktop, networking, hardware, services, and performance concerns
{ ... }:

{
  imports = [
    ./boot.nix
    ./desktop.nix
    ./hardware.nix
    ./input.nix
    ./networking.nix
    ./packages.nix
    ./performance.nix
    ./services.nix
    ./users.nix
  ];
}

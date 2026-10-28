# modules/system/default.nix
{...}: {
  imports = [
    ./boot.nix
    ./desktop.nix
    ./env-vars.nix
    ./flake-packages.nix
    ./hardware.nix
    ./input.nix
    ./networking.nix
    ./packages.nix
    ./performance.nix
    ./programs.nix
    ./services.nix
    ./systemd.nix
    ./users.nix
    ./virtualisation.nix
  ];
}

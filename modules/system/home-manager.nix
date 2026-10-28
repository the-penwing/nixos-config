# modules/system/home-manager.nix
{
  inputs,
  system,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = {inherit inputs system;};
    users.benvl = import ../../home.nix;
  };
}

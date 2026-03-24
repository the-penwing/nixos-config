{
  description = "benvl NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    plank-reloaded.url = "github:zquestz/plank-reloaded";
    turntable-src = {
      url = "git+https://codeberg.org/penwings/Turntable";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, plank-reloaded, turntable-src, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    turntable = pkgs.callPackage ./turntable.nix {
      src = turntable-src;
    };
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.benvl = import ./home.nix;
        }
        {
          environment.systemPackages = [
            plank-reloaded.packages.${system}.default
            turntable
          ];
        }
      ];
    };
  };
}

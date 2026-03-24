{
  description = "benvl NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    plank-reloaded.url = "github:zquestz/plank-reloaded";
    naviterm = {
      url = "gitlab:detoxify92/naviterm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    turntable-src = {
      url = "git+https://codeberg.org/penwings/Turntable";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, plank-reloaded, naviterm, turntable-src, ... }@inputs:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations."bens-nixos-laptop" = nixpkgs.lib.nixosSystem {
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
            naviterm.packages.${system}.default
            (nixpkgs.legacyPackages.${system}.callPackage ./turntable.nix {
              src = turntable-src;
            })
          ];
        }
      ];
    };
  };
}

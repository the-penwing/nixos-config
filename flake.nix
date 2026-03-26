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
    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz"; # For latest stable version
      #url = "https://flakehub.com/f/Svenum/Solaar-Flake/0.1.7.tar.gz"; # uncomment line for solaar version 1.1.19
      #url = "github:Svenum/Solaar-Flake/main"; # Uncomment line for latest unstable version
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pawn-appetit-src = {
      url = "github:Pawn-Appetit/pawn-appetit";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, plank-reloaded, naviterm, turntable-src, solaar, pawn-appetit-src, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations."bens-nixos-laptop" = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        solaar.nixosModules.default
        home-manager.nixosModules.home-manager
		{
  		  home-manager.useGlobalPkgs = true;
		  home-manager.useUserPackages = true;
		  home-manager.users.benvl = import ./home.nix {
		    inherit pkgs;
		    turntable = nixpkgs.legacyPackages.${system}.callPackage ./turntable.nix {
      		  src = turntable-src;
    		};
  		  };
		}
        {
          environment.systemPackages = [
            plank-reloaded.packages.${system}.default
            naviterm.packages.${system}.default
            (nixpkgs.legacyPackages.${system}.callPackage ./turntable.nix {
              src = turntable-src;
            })
			(import (self + /pawn-appetit.nix) {
			  pkgs = nixpkgs.legacyPackages.${system};
			  src = pawn-appetit-src;
			})
          ];
        }
      ];
    };
  };
}

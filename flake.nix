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
    iloader.url = "github:nab138/iloader";
  };

  outputs = { self, nixpkgs, home-manager, plank-reloaded, naviterm, turntable-src, solaar, iloader, ... }@inputs:
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
            iloader.packages.${system}.default
            (nixpkgs.legacyPackages.${system}.callPackage ./turntable.nix {
              src = turntable-src;
            })
          ];
        }
      ];
    };
    devShells.x86_64-linux.pawn-appetit = pkgs.mkShell {
      buildInputs = with pkgs; [
        cargo
        rustc
        pnpm
        nodejs
        pkg-config
        gtk3
        webkitgtk_4_1
        libsoup_3
      ];
      
      shellHook = ''
        echo "Pawn-Appetit dev shell loaded"
      '';
    };
  };
}

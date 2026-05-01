{
  description = "benvl NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    naviterm = {
      url = "gitlab:detoxify92/naviterm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    iloader.url = "github:nab138/iloader";
  };

  outputs = { self, nixpkgs, home-manager, naviterm, solaar, iloader, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    mkDevShell = import ./lib/mkDevShell.nix { inherit pkgs; };
    mkMicrobitShell = import ./lib/mkMicrobitShell.nix { inherit pkgs; };
  in {
    nixosConfigurations."nixos-laptop" = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/nixos-laptop/configuration.nix
        solaar.nixosModules.default
        home-manager.nixosModules.home-manager
		{
  		  home-manager.useGlobalPkgs = true;
		  home-manager.useUserPackages = true;
		  home-manager.backupFileExtension = "bak";
		  home-manager.users.benvl = import ./home.nix {
		    inherit pkgs;
  		  };
		}
        {
          environment.systemPackages = [
            naviterm.packages.${system}.default
            iloader.packages.${system}.default
          ];
        }
      ];
    };

    devShells.x86_64-linux = {
      default = mkDevShell {
        buildInputs = with pkgs; [
          git
          rsync
        ];
        
        shellHook = ''
          echo "nixos-config shell loaded"
        '';
      };

      pawn-appetit = mkDevShell {
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

      microbit-python = mkMicrobitShell {
        python = true;
        rust = false;
        shellMessage = "micro:bit MicroPython dev shell loaded";
        includeVenvHint = true;
      };

      microbit-rust = mkMicrobitShell {
        rust = true;
        shellMessage = "micro:bit Rust dev shell loaded";
      };

      microbit = mkMicrobitShell {
        python = true;
        rust = true;
        shellMessage = "micro:bit combined Python + Rust dev shell loaded";
        includeVenvHint = true;
      };
    };
  };
}

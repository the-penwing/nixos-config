# Flake entrypoint for Ben's NixOS + Home Manager setup.
#
# Purpose:
# - Define all upstream inputs
# - Export host configuration and development shells
{
  description = "benvl NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    naviterm = {
      url = "gitlab:detoxify92/naviterm";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cherri.url = "github:electrikmilk/cherri";
  };

  outputs = { self, nixpkgs, home-manager, naviterm, solaar, cherri, caelestia-shell, caelestia-cli, ... }@inputs:
    let
      system = "x86_64-linux";
      overlays = import ./overlays/default.nix;
      pkgs = import nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };
      mkShell = import ./dev-envs/base-shell.nix { inherit pkgs; };
    in
    {
      nixosConfigurations."nixos-p14s" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/nixos-p14s/configuration.nix
          solaar.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = overlays;

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "bak";
            home-manager.sharedModules = [
              caelestia-shell.homeManagerModules.default
            ];
            home-manager.users.benvl = import ./home.nix { inherit pkgs; };
          }
          {
            environment.systemPackages = [
              naviterm.packages.${system}.default
              cherri.packages.${system}.default
              caelestia-shell.packages.${system}.default
              caelestia-cli.packages.${system}.default
            ];
          }
        ];
      };

      devShells = let shells = (import ./dev-envs { inherit pkgs; }); in {
        x86_64-linux = {
          pawn-appetit = mkShell {
            buildInputs = shells.pawn-appetit.buildInputs;
            shellHook = shells.pawn-appetit.shellHook;
          };
          bash-scripting = mkShell {
            buildInputs = shells.bash-scripting.buildInputs;
            shellHook = shells.bash-scripting.shellHook;
          };
          rust = mkShell {
            buildInputs = shells.rust.buildInputs;
            shellHook = shells.rust.shellHook;
          };
        };
      };
    };
}

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

    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";

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

  outputs =
    { self
    , nixpkgs
    , home-manager
    , naviterm
    , solaar
    , cherri
    , caelestia-shell
    , caelestia-cli
    , rust-overlay
    , ...
    }@inputs:
    let
      system = "x86_64-linux";
      overlays = (import ./overlays/default.nix) ++ [ rust-overlay.overlays.default ];
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
              # Rust toolchain with rust-src for rust-analyzer
              (pkgs.rust-bin.stable.latest.default.override {
                extensions = [
                  "rust-src"
                  "rust-analyzer"
                ];
                targets = [
                  # --- Personal Deployment Targets ---
                  "i686-unknown-linux-musl"     # iSH Shell
                  "aarch64-unknown-linux-gnu"   # Raspberry Pi (Standard)
                  "aarch64-unknown-linux-musl"  # Raspberry Pi (Alpine)

                  # --- Common Desktop Targets ---
                  "x86_64-pc-windows-gnu"       # Windows 64-bit
                  "aarch64-apple-darwin"        # Apple Silicon Mac
                  "x86_64-apple-darwin"         # Intel Mac
                  "x86_64-unknown-linux-gnu"    # Standard Desktop Linux (glibc)
                  "x86_64-unknown-linux-musl"   # Static Desktop Linux (musl)
                ];
              })
            ];
          }
        ];
      };

      devShells =
        let
          shells = (import ./dev-envs { inherit pkgs; });
        in
        {
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

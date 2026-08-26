# Flake entrypoint for Ben's NixOS + Home Manager setup.
#
# Purpose:
# - Define all upstream inputs
# - Export host configuration and development shells
{
  description = "benvl NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    bacon = {
      url = "github:Canop/bacon";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    bacon-ls = {
      url = "github:crisidev/bacon-ls";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    naviterm = {
      url = "gitlab:detoxify92/naviterm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ghostty,
    rust-overlay,
    bacon,
    bacon-ls,
    naviterm,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    overlays =
      (import ./overlays/default.nix)
      ++ [
        ghostty.overlays.default
        rust-overlay.overlays.default
        bacon.overlay.${system}
        bacon-ls.overlay.${system}
      ];
    pkgs = import nixpkgs {
      inherit system overlays;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations."nixos-p14s" = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/nixos-p14s/configuration.nix
        home-manager.nixosModules.home-manager
        {
          nixpkgs.overlays = overlays;

          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "bak";
            users.benvl = import ./home.nix {inherit pkgs;};
          };
        }
        {
          environment.systemPackages = [
            pkgs.ghostty
            pkgs.bacon
            pkgs.bacon-ls
            naviterm.packages.${system}.default
            # Rust toolchain with rust-src for rust-analyzer
            (pkgs.rust-bin.stable.latest.default.override {
              extensions = [
                "rust-src"
                "rust-analyzer"
              ];
              targets = [
                # --- Personal Deployment Targets ---
                "i686-unknown-linux-musl" # iSH Shell
                "aarch64-unknown-linux-gnu" # Raspberry Pi (Standard)
                "aarch64-unknown-linux-musl" # Raspberry Pi (Alpine)

                # --- RP2350 ---
                "thumbv8m.main-none-eabihf"
                "riscv32imac-unknown-none-elf"

                # --- Mobile + WASM ---
                "wasm32-unknown-unknown"
                "aarch64-linux-android"
                "armv7-linux-androideabi"
                "x86_64-linux-android"
                "i686-linux-android"
                "aarch64-apple-ios"
                "x86_64-apple-ios"

                # --- Common Desktop Targets ---
                "x86_64-pc-windows-gnu" # Windows 64-bit
                "aarch64-apple-darwin" # Apple Silicon Mac
                "x86_64-apple-darwin" # Intel Mac
                "x86_64-unknown-linux-gnu" # Standard Desktop Linux (glibc)
                "x86_64-unknown-linux-musl" # Static Desktop Linux (musl)
              ];
            })
          ];
        }
      ];
    };
  };
}

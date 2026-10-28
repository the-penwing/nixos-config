# flake.nix
{
  description = "NixOS config for the-penwing (benvl)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    the-penwing.url = "github:the-penwing/nix-repo";
    elephant.url = "github:abenz1267/elephant";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    ghostty.url = "github:ghostty-org/ghostty";
    ghostty.inputs.nixpkgs.follows = "nixpkgs";

    walker.url = "github:abenz1267/walker";
    walker.inputs.nixpkgs.follows = "nixpkgs";
    walker.inputs.elephant.follows = "elephant";

    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";

    bacon.url = "github:Canop/bacon";
    bacon.inputs.nixpkgs.follows = "nixpkgs";

    bacon-ls.url = "github:crisidev/bacon-ls";
    bacon-ls.inputs.nixpkgs.follows = "nixpkgs";

    naviterm.url = "gitlab:detoxify92/naviterm";
    naviterm.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    overlays =
      (import ./overlays/default.nix)
      ++ [
        inputs.ghostty.overlays.default
        inputs.rust-overlay.overlays.default
        inputs.bacon.overlay.${system}
        inputs.bacon-ls.overlay.${system}
      ];
  in {
    nixosConfigurations."nixos-p14s" = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs system;};
      modules = [
        ./hosts/nixos-p14s/configuration.nix
        home-manager.nixosModules.home-manager
        {
          nixpkgs.overlays = overlays;
          nixpkgs.config = {
            allowUnfree = true;
            android_sdk.accept_license = true;
          };

          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "bak";
            extraSpecialArgs = {inherit inputs system;};
            users.benvl = import ./home.nix;
          };
        }
        ({pkgs, ...}: {
          environment.systemPackages = [
            # My packages
            inputs.the-penwing.packages.${system}.blackjack-slint
            inputs.the-penwing.packages.${system}.blackjack-rs
            inputs.the-penwing.packages.${system}.lua-dungeon-crawler

            pkgs.bacon
            pkgs.bacon-ls
            inputs.walker.packages.${system}.default
            inputs.elephant.packages.${system}.elephant-with-providers
            inputs.naviterm.packages.${system}.default
            # Rust toolchain with rust-src for rust-analyzer
            (pkgs.rust-bin.stable.latest.default.override {
              extensions = [
                "rust-src"
                "rust-analyzer"
              ];
              targets = [
                "x86_64-unknown-linux-gnu"
                "aarch64-unknown-linux-musl" # Raspberry Pi (Alpine)
              ];
            })
          ];
        })
      ];
    };
  };
}

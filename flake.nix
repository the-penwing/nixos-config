# flake.nix
{
  description = "NixOS config for the-penwing (benvl)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    the-penwing.url = "github:the-penwing/nix-repo";
    the-penwing.inputs.nixpkgs.follows = "nixpkgs";

    ghostty.url = "github:ghostty-org/ghostty";
    ghostty.inputs.nixpkgs.follows = "nixpkgs";

    blip.url = "github:blip-net/nix";
    blip.inputs.nixpkgs.follows = "nixpkgs";

    elephant.url = "github:abenz1267/elephant";
    elephant.inputs.nixpkgs.follows = "nixpkgs";

    walker.url = "github:abenz1267/walker";
    walker.inputs.nixpkgs.follows = "nixpkgs";
    walker.inputs.elephant.follows = "elephant";

    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";

    bacon.url = "github:Canop/bacon";
    bacon.inputs.nixpkgs.follows = "nixpkgs";
    bacon.inputs.naersk.inputs.nixpkgs.follows = "nixpkgs";

    bacon-ls.url = "github:crisidev/bacon-ls";
    bacon-ls.inputs.nixpkgs.follows = "nixpkgs";
    bacon-ls.inputs.naersk.inputs.nixpkgs.follows = "nixpkgs";

    naviterm.url = "gitlab:detoxify92/naviterm";
    naviterm.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";
  in {
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;

    nixosConfigurations."nixos-p14s" = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs system;};
      modules = [./hosts/nixos-p14s/configuration.nix];
    };
  };
}

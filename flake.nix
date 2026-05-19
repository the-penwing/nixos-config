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
    sheetsui.url = "github:zaphar/sheetsui";
  };

  outputs = { self, nixpkgs, home-manager, naviterm, solaar, cherri, caelestia-shell, caelestia-cli, sheetsui, ... }@inputs:

  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    mkDevShell = import ./lib/mkDevShell.nix { inherit pkgs; };
    mkMicrobitShell = import ./lib/mkMicrobitShell.nix { inherit pkgs; };
  in {
    nixosConfigurations."nixos-t14s" = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/nixos-t14s/configuration.nix
        solaar.nixosModules.default
        home-manager.nixosModules.home-manager
		{
  		  home-manager.useGlobalPkgs = true;
		  home-manager.useUserPackages = true;
		  home-manager.backupFileExtension = "bak";
      home-manager.sharedModules = [
        caelestia-shell.homeManagerModules.default
      ];
		  home-manager.users.benvl = import ./home.nix {
		    inherit pkgs;
  		  };
		}
        {
          environment.systemPackages = [
            naviterm.packages.${system}.default
            cherri.packages.${system}.default
            caelestia-shell.packages.${system}.default
            caelestia-cli.packages.${system}.default
            sheetsui.packages.${system}.default
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

      bash-scripting = mkDevShell {
        buildInputs = with pkgs; [
          bashInteractive
          bash-completion
          shellcheck
          shfmt
          bats
          jq
          yq-go
          nodePackages.bash-language-server
        ];

        shellHook = ''
          eval "$(${pkgs.zoxide}/bin/zoxide init bash)"

          alias cat='bat --paging=never'
          alias ls='eza'
          alias ll='eza --icons -l'
          alias la='eza --icons -la'
          alias grep='rg'
          alias find='fd'
          alias du='dust'
          alias df='duf'
          alias ps='btop'
          alias cd='z'

          echo "bash-scripting dev shell loaded"
          echo "Tooling: shellcheck, shfmt, bats, bash-language-server"
        '';
      };
    };
  };
}

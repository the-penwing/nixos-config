{...}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = {
        source = "~/.config/fastfetch/ascii/nixos.txt";
        padding = {
          top = 2;
          right = 6;
        };
      };
      display = {
        separator = " ";
      };
      modules = [
        "break"
        "break"
        {
          type = "title";
          keyWidth = 10;
        }
        "break"
        {
          type = "os";
          key = " ";
          keyColor = "33";
        }
        {
          type = "kernel";
          key = " ";
          keyColor = "33";
        }
        {
          type = "packages";
          format = "{nix-all} (nixpkgs)";
          key = " ";
          keyColor = "33";
        }
        {
          type = "shell";
          key = " ";
          keyColor = "33";
        }
        {
          type = "terminal";
          key = " ";
          keyColor = "33";
        }
        {
          type = "wm";
          key = " ";
          keyColor = "33";
        }
        {
          type = "uptime";
          key = " ";
          keyColor = "33";
        }
        "break"
        "colors"
        "break"
        "break"
      ];
    };
  };
  xdg.configFile."fastfetch/ascii/nixos.txt".source = ./ascii/nixos.txt;
  xdg.configFile."fastfetch/ascii/nixos-wrath.txt".source = ./ascii/nixos-wrath.txt;
}

{...}: {
  programs.atuin = {
    enable = true;
    settings = {
      sync_address = "https://atuin.taile9a1d6.ts.net";
      sync_frequency = "10m";

      inline_height = 15;

      show_help = true;
      show_tabs = true;

      theme = {
        name = "dracula";
      };

      daemon = {
        enabled = true;
        autostart = true;
      };
    };
    themes = {
      dracula = {
        theme.name = "dracula";

        colors = {
          Base = "#f8f8f2";
          Guidance = "#8be9fd";
          Important = "#ff79c6";
          Annotation = "#bd93f9";
          AlertInfo = "#50fa7b";
          AlertWarn = "#f1fa8c";
          AlertError = "#ff5555";
        };
      };
    };
  };
}

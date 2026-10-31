{
  inputs,
  system,
  ...
}: {
  programs.ghostty = {
    enable = true;
    package = inputs.ghostty.packages.${system}.default;
    enableZshIntegration = false;
    settings = {
      theme = "Dracula";
      font-family = "MesloLGS Nerd Font";
      font-size = 12;
      adjust-cell-height = 1;
      window-padding-x = 5;
      window-padding-y = 5;
      window-decoration = "none";
      background-opacity = 0.70;
      background-blur = false;
      window-save-state = "always";
      auto-update = "off";
      clipboard-read = "allow";
      clipboard-write = "allow";
      copy-on-select = "clipboard";
      focus-follows-mouse = true;
      shell-integration = "zsh";
      shell-integration-features = "no-cursor,sudo,title";
      scrollback-limit = 20000;
      mouse-hide-while-typing = true;
      cursor-style = "block";
      cursor-style-blink = true;

      keybind = [
        "ctrl+enter=text:\\r"
        "ctrl+j=text:\\n"
      ];
    };
  };
}

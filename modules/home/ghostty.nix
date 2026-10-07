{...}: {
  programs.ghostty = {
    enable = true;
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
    };
  };
}

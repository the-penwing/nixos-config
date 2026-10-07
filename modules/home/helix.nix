{...}: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "transparent_dracula";

      editor = {
        auto-format = true;
        line-number = "relative";
        mouse = true;
        cursorline = true;
        scrolloff = 5;
        bufferline = "always";
        color-modes = true;
        idle-timeout = 0;
        completion-trigger-len = 1;
        default-yank-register = "+";
        auto-save = {
          focus-lost = true;
          after-delay = {
            enable = true;
            timeout = 3000;
          };
        };
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        file-picker = {
          hidden = false;
        };
        statusline = {
          left = ["mode" "spinner" "file-name" "file-modification-indicator"];
          center = [];
          right = ["diagnostics" "selections" "position" "file-encoding" "file-type"];
        };
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        indent-guides = {
          render = true;
          character = "│";
        };
      };
    };
    themes = {
      transparent_dracula = {
        inherits = "dracula";
        "ui.background" = {};
      };
    };
  };
  xdg.configFile."helix/runtime/queries/html/indents.scm".source =
    ./imports/queries/html/indents.scm;
}

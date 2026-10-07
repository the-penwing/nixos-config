{pkgs, ...}: {
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
    languages = {
      language-server = {
        bash-language-server = {
          command = "bash-language-server";
          args = ["start"];
        };
        lua-language-server = {
          command = "lua-language-server";
        };
        nil = {
          command = "nil";
        };
        nixd = {
          command = "nixd";
        };
        pyright = {
          command = "pyright-langserver";
          args = ["--stdio"];
        };
        ruff = {
          command = "ruff";
          args = ["server"];
        };
        tombi = {
          command = "tombi";
          args = ["lsp"];
        };
        yaml-language-server = {
          command = "yaml-language-server";
          args = ["--stdio"];
        };
        marksman = {
          command = "marksman";
          args = ["server"];
        };
        clangd = {
          command = "clangd";
          args = ["--query-driver=/run/current-system/sw/bin/*"];
        };
        vscode-html-language-server = {
          command = "vscode-html-language-server";
          args = ["--stdio"];
        };
        vscode-css-language-server = {
          command = "vscode-css-language-server";
          args = ["--stdio"];
        };
        vscode-json-language-server = {
          command = "vscode-json-language-server";
          args = ["--stdio"];
        };
        rust-analyzer = {
          command = "rust-analyzer";
          config = {
            cargo = {
              buildScripts = {
                enable = true;
              };
            };
            checkOnSave = {
              command = "clippy";
            };
          };
        };
      };
      language = [
        {
          name = "rust";
          language-servers = ["rust-analyzer"];
          formatter = {command = "rustfmt";};
          auto-format = true;
        }
        {
          name = "c";
          language-servers = ["clangd"];
          formatter = {command = "clang-format";};
          auto-format = true;
        }
        {
          name = "lua";
          language-servers = ["lua-language-server"];
          formatter = {
            command = "stylua";
            args = ["-"];
          };
          auto-format = true;
        }
        {
          name = "nix";
          language-servers = ["nil" "nixd"];
          formatter = {command = "alejandra";};
          auto-format = true;
        }
        {
          name = "python";
          language-servers = ["pyright" "ruff"];
          formatter = {
            command = "black";
            args = ["-"];
          };
          auto-format = true;
        }
        {
          name = "bash";
          language-servers = ["bash-language-server"];
          formatter = {command = "shfmt";};
          auto-format = true;
        }
        {
          name = "html";
          language-servers = [
            "vscode-html-language-server"
          ];
          formatter = {
            command = "prettier";
            args = ["--parser" "html"];
          };
          auto-format = true;
        }
        {
          name = "css";
          language-servers = ["vscode-css-language-server"];
          formatter = {
            command = "prettier";
            args = ["--parser" "css"];
          };
          auto-format = true;
        }
        {
          name = "json";
          language-servers = ["vscode-json-language-server"];
          formatter = {
            command = "prettier";
            args = ["--parser" "json"];
          };
          auto-format = true;
        }
        {
          name = "jsonc";
          language-servers = ["vscode-json-language-server"];
          formatter = {
            command = "prettier";
            args = ["--parser" "json"];
          };
          auto-format = true;
        }
        {
          name = "toml";
          language-servers = ["tombi"];
          auto-format = true;
        }
        {
          name = "yaml";
          language-servers = ["yaml-language-server"];
          formatter = {
            command = "yamlfmt";
            args = ["-"];
          };
          auto-format = true;
        }
        {
          name = "markdown";
          language-servers = ["marksman"];
        }
      ];
    };
    extraPackages = with pkgs; [
      bash-language-server
      lua-language-server
      marksman
      shfmt
      tombi
      vscode-langservers-extracted
      yaml-language-server
      yamlfmt
    ];
  };
  xdg.configFile."helix/runtime/queries/html/indents.scm".source =
    ./imports/queries/html/indents.scm;
}

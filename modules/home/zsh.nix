{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    history = {
      size = 50000;
      save = 50000;
      path = "${config.home.homeDirectory}/.zsh_history";
      ignoreAllDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
      share = true;
    };

    shellAliases = {
      update-repo-dotfiles = "~/nixos-config/scripts/sync-dotfiles push";
      update-home-dotfiles = "~/nixos-config/scripts/sync-dotfiles pull";
      rebuild = "~/nixos-config/scripts/rebuild";
      rollback-system = "~/nixos-config/scripts/rollback";

      python3 = "python3.14";
      python = "python3.14";
      pip = "uv pip";
      evil-winrm = "evil-winrm-py";
      tree-no-docs = "tree --gitignore -I '*.md' --prune";
      czb = "cargo zigbuild";
      czbr = "cargo zigbuild --release";
      rust-docs = "xdg-open \"$(rustc --print sysroot)/share/doc/rust/html/index.html\"";
      ns = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
      nso = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --bind 'enter:execute(nix-search-tv preview {})+accept'";
      sesh-fzf = "sesh connect \"$(sesh list | fzf)\"";

      ls = "eza --icons=auto";
      ll = "eza --icons -l";
      la = "eza --icons -la";
      tree = "eza --icons -T";
      cd = "z";
      cdi = "zi";
      fm = "yy";
    };

    autosuggestion = {
      enable = true;
      strategy = [
        "history"
        "completion"
      ];
    };

    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
    ];

    initContent = ''

      zstyle ':fzf-tab:*' fzf-flags --color=dark '--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f' '--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7' --style default
      zstyle ':fzf-tab:*' fzf-min-height 6

      export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
      export GPG_TTY="$TTY"
      export TIMEFMT=$'\nreal %*E\nuser %*U\nsys %*S\n'
      typeset -U path fpath
      path+=("$HOME/nixos-config/scripts" "$HOME/.cargo/bin")
      export PATH

      source ~/.config/zsh/zshrc.d/20-integrations.zsh
      source ~/.config/zsh/zshrc.d/50-atuin.zsh
      source ~/.config/zsh/zshrc.d/60-hyprland.zsh
    '';
  };
  home.sessionVariables = {
    BAT_THEME = "Dracula";
    FZF_DEFAULT_COMMAND = "fd";
    FZF_DEFAULT_OPTS = "--color=dark --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7 --style default --preview 'bat --style=numbers --color=always --line-range :500 {}'";
    MANPAGER = "nvim +Man!";
    SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
    SDKROOT = "${config.home.homeDirectory}/dev/sdks/MacOSX15.5.sdk";
    PICO_SDK_PATH = "${config.home.homeDirectory}/dev/hardware/pico2/cc/pico-sdk";
    BEMOJI_PICKER_CMD = "fuzzel -d";
  };
}

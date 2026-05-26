# Home shell/developer ergonomics module.
#
# Purpose:
# - Keep per-user shell tooling and environment variables together
# - Manage direnv, starship, and fzf declaratively via home-manager
# - Keep SSH agent behaviour explicit and auditable
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lazygit
    sassc
  ];

  home.sessionPath = [
    "$HOME/.npm-global/bin"
  ];

  home.sessionVariables.npm_config_prefix = "~/.npm-global";

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = [
      "--color=dark"
      "--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f"
      "--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7"
      "--style=full"
    ];
  };

  programs.zsh = {
    enable = true;
    initExtra = ''
      zstyle ':fzf-tab:*' fzf-min-height 6
    '';
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*" = {
      addKeysToAgent = "yes";
      identityFile = "~/.ssh/id_ed25519";
    };
  };

  programs.git.enable = true;
}

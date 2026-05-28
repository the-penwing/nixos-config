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
    zsh-autosuggestions
    zsh-syntax-highlighting
  ];

  home.sessionPath = [
    "$HOME/.npm-global/bin"
    "$HOME/.cargo/bin"
    "$HOME/.local/bin"
  ];

  programs.direnv = {
    enable = true;
  };

  programs.starship = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
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

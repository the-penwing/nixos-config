{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs
    python3
    pkg-config
    gcc
    gnumake
    rustup
    sassc
    lazygit
    tea
    pyenv
    uv
  ];

  home.sessionPath = [
    "$HOME/.npm-global/bin"
  ];

  home.file.".npmrc".text = ''
    prefix=$HOME/.npm-global
  '';

  # Zsh - Shell Configuration
  home.file.".zshrc".source = ../../dotfiles/shell/zsh/.zshrc;

  # Tmux - Terminal Multiplexer
  home.file.".tmux.conf".source = ../../dotfiles/shell/tmux/.tmux.conf;

  # Starship - Shell Prompt
  xdg.configFile."starship.toml".source = ../../dotfiles/shell/starship.toml;
}

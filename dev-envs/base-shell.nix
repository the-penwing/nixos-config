{ pkgs }:
{
  buildInputs ? [ ],
  shellHook ? "",
  starshipConfig ? ../dotfiles/shell/starship.toml,
}:

let
  commonInputs = with pkgs; [
    git
    starship
    jq
    fzf
    ripgrep
    fd
    bat
    eza
    zoxide
  ];
in

pkgs.mkShell {
  buildInputs = commonInputs ++ buildInputs;

  shellHook = ''
    ${shellHook}
    eval "$(${pkgs.zoxide}/bin/zoxide init bash)"

    alias cat='bat'
    alias ls='eza'
    alias ll='eza --icons -l'
    alias la='eza --icons -la'
    alias grep='rg'
    alias find='fd'
    alias du='dust'
    alias df='duf'
    alias ps='btop'
    alias cd='z'
    alias cdi='zi'

    export STARSHIP_CONFIG=${starshipConfig}
    eval "$(${pkgs.starship}/bin/starship init bash)"
  '';
}

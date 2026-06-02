{ pkgs }:
{
  buildInputs ? [ ],
  shellHook ? "",
  starshipConfig ? ../dotfiles/shell/starship.toml,
}:
let
  commonInputs = with pkgs; [
    zsh
    starship
    fzf
    ripgrep
    fd
    bat
    eza
    direnv
    zoxide
  ];
in
pkgs.mkShell {
  buildInputs = buildInputs ++ commonInputs;

  shellHook = ''
    ${shellHook}
  
    export STARSHIP_CONFIG="${starshipConfig}"
    eval "$(${pkgs.starship}/bin/starship init bash)"
  '';
}

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
    export STARSHIP_CONFIG=${starshipConfig}
    eval "$(${pkgs.starship}/bin/starship init bash)"
  '';
}

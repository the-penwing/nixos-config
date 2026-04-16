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
  
    export SHELL=${pkgs.zsh}/bin/zsh
    export STARSHIP_CONFIG="${starshipConfig}"
    exec ${pkgs.zsh}/bin/zsh
  '';
}

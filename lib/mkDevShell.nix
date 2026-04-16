{ pkgs }:
{
  buildInputs ? [ ],
  shellHook ? "",
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
    export STARSHIP_CONFIG="${../dotfiles/shell/starship.toml}"

    case $- in
      *i*) exec ${pkgs.zsh}/bin/zsh -l ;;
    esac
  '';
}

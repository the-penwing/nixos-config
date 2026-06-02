{ pkgs }:
{
  packages = with pkgs; [
    bashInteractive
    bash-completion
    shellcheck
    shfmt
    bats
    yq-go
    bash-language-server
  ];
  shellHook = ''
    echo "Bash Scripting dev shell loaded"
  '';
}

{ pkgs }:
{
  packages = with pkgs; [
    git
    rsync
  ];
  shellHook = ''
    echo "nixos-config shell loaded"
  '';
}

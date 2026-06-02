{ pkgs }:
{
  packages = with pkgs; [
    cargo
    rustc
    rust-analyzer
    gcc
  ];
  shellHook = "";
}

{ pkgs }:
{
  packages = with pkgs; [
    cargo
    rustc
    rust-analyzer
    gcc
  ];
  shellHook = ''
    echo "Rust dev shell loaded"
  '';
}

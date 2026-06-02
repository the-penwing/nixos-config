{ pkgs }:
{
  packages = with pkgs; [
    cargo
    rustc
    pnpm
    nodejs
    pkg-config
    gtk3
    webkitgtk_4_1
    libsoup_3
  ];
  shellHook = ''
    echo "Pawn-Appetit dev shell loaded"
  '';
}

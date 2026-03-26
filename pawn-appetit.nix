{ pkgs, src }:

pkgs.stdenv.mkDerivation rec {
  pname = "pawn-appetit";
  version = "0.11.0";

  inherit src;

  nativeBuildInputs = with pkgs; [
    pkg-config
    cargo
    rustc
    pnpm
    nodejs
  ];

  buildInputs = with pkgs; [
    libxcb
    libxkbcommon
    libGL
    openssl
    gtk3
    webkitgtk_6_0
    libsoup_3
  ];

  buildPhase = ''
    export HOME=$(mktemp -d)
    pnpm install --frozen-lockfile
    pnpm run build-vite
    
    cd src-tauri
    cargo build --release
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp target/release/pawn_appetit $out/bin/pawn-appetit
  '';

  meta = {
    description = "A chess GUI";
    homepage = "https://github.com/Pawn-Appetit/pawn-appetit";
    license = pkgs.lib.licenses.gpl3;
    platforms = pkgs.lib.platforms.linux;
  };
}

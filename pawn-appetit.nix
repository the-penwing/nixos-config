{ pkgs, src }:

pkgs.rustPlatform.buildRustBinary rec {
  pname = "pawn-appetit";
  version = "0.11.0";

  inherit src;

  sourceRoot = "${src.name}/src-tauri";

  nativeBuildInputs = with pkgs; [
    pkg-config
    cargo
    rustc
    pnpm
    nodejs
    typescript
  ];

  buildInputs = with pkgs; [
    libxcb
    libxkbcommon
    libGL
    openssl
    gtk3
    glib
    cairo
    pango
    atk
    gdk-pixbuf
    webkitgtk_6_0
  ];

  buildPhase = ''
    # Build frontend
    cd ..
    pnpm install --frozen-lockfile
    pnpm run build-vite
    cd src-tauri

    # Build Tauri app
    cargo build --release
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp target/release/pawn-appetit $out/bin/
  '';

  meta = {
    description = "A chess GUI";
    homepage = "https://github.com/Pawn-Appetit/pawn-appetit";
    license = pkgs.lib.licenses.gpl3;
    platforms = pkgs.lib.platforms.linux;
  };
}

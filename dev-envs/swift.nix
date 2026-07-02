{pkgs}: {
  packages = with pkgs; [
    # Core Swift Toolchain
    swift
    swiftpm

    # OpenSwiftUI Rendering & Linux GUI Dependencies
    pkg-config
    gtk4
    glib
    cairo

    # Windows Cross-Compilation Toolchain & C runtime libraries
    pkgsCross.mingwW64.stdenv.cc
    pkgsCross.mingwW64.windows.pthreads
  ];

  shellHook = ''
    echo "========================================================"
    echo " Swift & OpenSwiftUI Dev Shell Loaded"
    echo " Swift version: $(swift --version | head -n1)"
    echo "========================================================"
    echo " CLI Commands:"
    echo " - Create CLI App: swift package init --type executable"
    echo " - Build / Run: swift build && swift run"
    echo "========================================================"
  '';
}

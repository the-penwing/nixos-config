{pkgs}: {
  packages = with pkgs; [
    (pkgs.rust-bin.stable.latest.default.override {
      extensions = [
        "rust-src"
        "rust-analyzer"
      ];
      targets = [
        # --- Personal Deployment Targets ---
        "i686-unknown-linux-musl" # iSH Shell
        "aarch64-unknown-linux-gnu" # Raspberry Pi (Standard)
        "aarch64-unknown-linux-musl" # Raspberry Pi (Alpine)

        # --- Common Desktop Targets ---
        "x86_64-pc-windows-gnu" # Windows 64-bit
        "aarch64-apple-darwin" # Apple Silicon Mac
        "x86_64-apple-darwin" # Intel Mac
        "x86_64-unknown-linux-gnu" # Standard Desktop Linux (glibc)
        "x86_64-unknown-linux-musl" # Static Desktop Linux (musl)
      ];
    })

    gcc
    cargo-zigbuild
    zig
  ];

  shellHook = ''
    echo "Rust DevShell Loaded"
    echo "  Rust: $(cargo --version)"
    echo "  GCC: $(gcc --version | head -n1)"
    echo "  Zig: $(zig version)"
  '';
}

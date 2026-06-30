{pkgs}: {
  packages = with pkgs; [
    # Rust
    (pkgs.rust-bin.stable.latest.default.override {
      extentions = ["rust-src" "rust-analyzer"];
      targets = ["thumbv8m.base-none-eabihf"];
    })

    # C toolchain for ARM Cortex
    gcc-arm-embedded

    # RP2350/Pico SDK
    pico-sdk

    # Python + MicroPython
    python311
    micropython

    # Flashing and Debugging
    picotool
    openocd-rp2040

    # Build Essentials
    cmake
    pkg-config
    zig
  ];

  shellHook = ''
    echo "RP2350 dev env loaded"
    echo "  Rust: $(cargo --version)"
    echo "  GCC ARM: $(arm-none-eabi-gcc --version | head -n1)"
    echo "  Python: $(python3 --version)"
    echo "  MicroPython: $(micropython --version 2>&1 || echo 'installed')"
    echo "  Zig: $(zig version)"
  '';
}

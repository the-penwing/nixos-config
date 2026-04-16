# Example workflows

## Edit → lint → build → flash → test

```bash
# Rust
cargo fmt --all
cargo clippy --all-targets --all-features -- -D warnings
cargo build
cargo embed

# Python
black .
ruff check .
# build/package as needed
esptool.py --chip <chip-id> --port /dev/ttyUSB0 --baud 460800 write_flash 0x1000 firmware.bin
```

## Auto-rebuild on save with `cargo-watch`

```bash
nix develop .#microbit-rust
cargo watch -x check -x test
```

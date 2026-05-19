# Example workflows

## Edit → lint → build → flash → test

```bash
# Rust (micro:bit)
nix develop .#microbit-rust
cargo fmt --all
cargo clippy --all-targets --all-features -- -D warnings
cargo build --release --target thumbv7em-none-eabihf
cargo embed

# Python (micro:bit)
nix develop .#microbit-python
black .
ruff check .
pip install uflash
uflash main.py --output firmware.hex
uflash main.py
```

## Auto-rebuild on save with `cargo-watch`

```bash
nix develop .#microbit-rust
cargo watch -x check -x test
```

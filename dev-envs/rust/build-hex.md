# Building `.hex` files for Rust

Use this when you start learning Rust on micro:bit.

## Build for the correct target

```bash
nix develop .#microbit-rust
rustup target add thumbv7em-none-eabihf
cargo build --release --target thumbv7em-none-eabihf
```

## Generate `.hex` from `.elf` with `objcopy`

```bash
rust-objcopy -O ihex target/thumbv7em-none-eabihf/release/<your-binary> firmware.hex
```

## Optional: use `cargo-binutils`

```bash
cargo install cargo-binutils
cargo objcopy --release --target thumbv7em-none-eabihf -- -O ihex firmware.hex
```

## Example workflow

```bash
nix develop .#microbit-rust
cargo fmt --all
cargo clippy --all-targets --all-features -- -D warnings
cargo build --release --target thumbv7em-none-eabihf
rust-objcopy -O ihex target/thumbv7em-none-eabihf/release/<your-binary> firmware.hex
```

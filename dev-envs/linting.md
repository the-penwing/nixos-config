# Linting & formatting

## Rust

```bash
nix develop .#microbit-rust
cargo fmt --all
cargo clippy --all-targets --all-features -- -D warnings
```

## Python

```bash
nix develop .#microbit-python
black .
ruff check .
```

Editor integration for Rust is already covered by `rust-analyzer` in the shell.

# Development environments

This repository provides lightweight, modular, **micro:bit-specific** dev shells.

## Available shells

### `microbit-python`

Enter:

```bash
nix develop .#microbit-python
```

Includes:
- `python3`
- `pip`
- `uv`
- `venv` support via `python3 -m venv`

Example:

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

---

### `microbit-rust`

Enter:

```bash
nix develop .#microbit-rust
```

Includes:
- `rustup`
- `cargo`
- `rustc`
- `rust-analyzer`
- `cargo-watch`

Example:

```bash
cargo build
cargo watch -x check
```

---

### `microbit` (combined)

Enter:

```bash
nix develop .#microbit
```

Includes both `microbit-python` and `microbit-rust` toolsets.

## Adding project-specific dependencies

Keep these base shells lightweight. For project-specific tools, create a local `flake.nix` in your project that extends the relevant shell with extra packages.

# Development environments

This repository provides lightweight, modular, **micro:bit-specific** dev shells for Rust, Python, and a combined workflow.

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
- `esptool`
- `minicom`, `screen`, `picocom`
- `black`, `ruff`, `mypy`
- `ipython`
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
- `cargo-embed`, `probe-rs`, `openocd`
- `rustfmt`
- `cargo-expand`, `cargo-bloat`
- `clippy` (installed via `rustup component add clippy` in shell hook)

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

Includes all tools from both `microbit-python` and `microbit-rust`.

## Building `.hex` files

Use the split guides below:

- [Python `.hex` guide (beginner-first)](./python/build-hex.md)
- [Rust `.hex` guide (future learning)](./rust/build-hex.md)
- [Comparison, workflow, and troubleshooting](./hex-workflow.md)

## Flashing code

### Rust: flash with `cargo-embed`

1. Enter the Rust shell.
2. Build your firmware.
3. Flash with `cargo embed`.

```bash
nix develop .#microbit-rust
cargo build
cargo embed
```

If your project needs a specific chip/target, configure `Embed.toml` in your Rust project and re-run `cargo embed`.

### Rust: flash/debug with `probe-rs`

1. Enter the Rust shell.
2. Verify your probe/device is detected.
3. Run the firmware on the selected chip.

```bash
nix develop .#microbit-rust
probe-rs list
probe-rs run --chip <your-chip> target/thumbv7em-none-eabihf/debug/<your-binary>
```

### Python: upload with `esptool`

1. Enter the Python shell.
2. Connect your board and identify its serial port.
3. Upload the firmware/image with `esptool`.

```bash
nix develop .#microbit-python
esptool.py --chip <chip-id> --port /dev/ttyUSB0 --baud 460800 write_flash 0x1000 firmware.bin
```

Adjust chip, serial port, baud rate, and flash offset for your board.
Use this flow for esptool-compatible targets in your microcontroller workflow.

### Debug serial output (`minicom` / `screen`)

1. Identify your serial port (`/dev/ttyUSB0` or `/dev/ttyACM0`).
2. Open a serial monitor with one of the commands below.

```bash
# minicom
minicom -D /dev/ttyUSB0 -b 115200

# screen
screen /dev/ttyUSB0 115200
```

`picocom` is also available:

```bash
picocom /dev/ttyUSB0 -b 115200
```

## Linting & formatting

### Rust

```bash
nix develop .#microbit-rust
cargo fmt --all
cargo clippy --all-targets --all-features -- -D warnings
```

### Python

```bash
nix develop .#microbit-python
black .
ruff check .
```

Editor integration for Rust is already covered by `rust-analyzer` in the shell.

## Troubleshooting

- **USB permissions**: if flashing tools cannot access the device, confirm udev rules/group membership and reconnect the board.
- **Serial port access**: ensure your user can access `/dev/ttyUSB*` or `/dev/ttyACM*` (often via `dialout` group).
- **Device detection**: use `probe-rs list` for debug probes and `ls /dev/ttyUSB* /dev/ttyACM*` for serial devices.

## Example workflows

### Edit → lint → build → flash → test

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

### Auto-rebuild on save with `cargo-watch`

```bash
nix develop .#microbit-rust
cargo watch -x check -x test
```

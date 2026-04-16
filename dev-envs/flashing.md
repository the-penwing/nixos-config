# Flashing code

## Rust: flash with `cargo-embed`

1. Enter the Rust shell.
2. Build your firmware.
3. Flash with `cargo embed`.

```bash
nix develop .#microbit-rust
cargo build
cargo embed
```

If your project needs a specific chip/target, configure `Embed.toml` in your Rust project and re-run `cargo embed`.

## Rust: flash/debug with `probe-rs`

1. Enter the Rust shell.
2. Verify your probe/device is detected.
3. Run the firmware on the selected chip.

```bash
nix develop .#microbit-rust
probe-rs list
probe-rs run --chip <your-chip> target/thumbv7em-none-eabihf/debug/<your-binary>
```

## Python: upload with `esptool`

1. Enter the Python shell.
2. Connect your board and identify its serial port.
3. Upload the firmware/image with `esptool`.

```bash
nix develop .#microbit-python
esptool.py --chip <chip-id> --port /dev/ttyUSB0 --baud 460800 write_flash 0x1000 firmware.bin
```

Adjust chip, serial port, baud rate, and flash offset for your board.
Use this flow for esptool-compatible targets in your microcontroller workflow.

## Debug serial output (`minicom` / `screen`)

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

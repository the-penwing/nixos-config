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

### Building `.hex` files for Python (recommended first)

#### Option 1: official micro:bit Python editor (easiest)

1. Open the official editor: <https://python.microbit.org/>
2. Write your code and click **Download**.
3. The editor generates a ready-to-flash `.hex` file.

This is the best beginner path because the editor bundles your script with the correct micro:bit MicroPython runtime.

#### Option 2: `uflash` (CLI)

```bash
nix develop .#microbit-python
pip install uflash
uflash main.py --output firmware.hex
```

You can also flash directly:

```bash
uflash main.py
```

#### Option 3: MicroPython compiler flow (`mpy-cross` + `uflash`)

Use this when you want to precompile modules for larger projects:

```bash
# compile module(s) to .mpy
mpy-cross lib/helpers.py

# then package your app to a .hex for micro:bit
uflash main.py --output firmware.hex
```

`mpy-cross` compiles Python modules, while `uflash` is still used to produce the final `.hex`.

#### Step-by-step beginner example

```python
from microbit import *

while True:
    display.scroll("Hi")
    sleep(1000)
```

Save as `main.py`, then:

```bash
nix develop .#microbit-python
pip install uflash
uflash main.py --output hello.hex
```

Copy `hello.hex` to the mounted `MICROBIT` drive.

#### Common micro:bit Python imports

- `from microbit import *` (display, buttons, accelerometer, pins, sleep)
- `import neopixel` (addressable LEDs)
- `import music` (tones and melodies)
- `import radio` (device-to-device messaging)
- `import speech` (speech synthesis on supported firmware builds)
- `import random` / `import utime` (helpers and timing)

### Building `.hex` files for Rust (future learning)

1. Build for the ARM Cortex-M target:

```bash
nix develop .#microbit-rust
rustup target add thumbv7em-none-eabihf
cargo build --release --target thumbv7em-none-eabihf
```

2. Convert ELF to HEX using `objcopy`:

```bash
rust-objcopy -O ihex target/thumbv7em-none-eabihf/release/<your-binary> firmware.hex
```

3. Optional (`cargo-binutils`) shorthand:

```bash
cargo install cargo-binutils
cargo objcopy --release --target thumbv7em-none-eabihf -- -O ihex firmware.hex
```

#### Example Rust workflow

```bash
nix develop .#microbit-rust
cargo fmt --all
cargo clippy --all-targets --all-features -- -D warnings
cargo build --release --target thumbv7em-none-eabihf
rust-objcopy -O ihex target/thumbv7em-none-eabihf/release/<your-binary> firmware.hex
```

### Python vs Rust `.hex` build comparison

| Approach | Typical `.hex` size | Typical build time | Best use case |
| --- | --- | --- | --- |
| Python (official editor / `uflash`) | Usually larger (runtime + script in one `.hex`) | Fast for rebuilds (often ~1-5s once tools are installed) | Learning, quick prototyping, classrooms |
| Python (`mpy-cross` + `uflash`) | Slightly smaller app payloads in some projects | Moderate (~3-10s) | Growing Python projects needing optimizations |
| Rust (`cargo build` + `objcopy`) | Usually smaller and more performance-focused firmware images | Typically slower (~10-60s; varies with project size, host speed, and clean vs incremental builds) | Performance, control, production-style embedded work |

### Beginner Python workflow

1. **Create**: write `main.py` with `from microbit import *`.
2. **Test locally (logic only)**: validate pure-Python helpers on your machine (for example parsing/math/state code).
3. **Build `.hex`**: use official editor download or `uflash main.py --output firmware.hex`.
4. **Flash**: copy `.hex` to `MICROBIT` drive.
5. **Debug**: monitor serial output with `minicom`, `screen`, or `picocom`.

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
- **`.hex` file too large**: remove unused imports/assets, simplify display animations, and prefer smaller helper modules; for Python, consider precompiled modules (`mpy-cross`) where appropriate.
- **Missing dependencies**: install required Python tooling in your venv (`pip install uflash`) and verify Rust target/tooling (`rustup target add thumbv7em-none-eabihf`, `cargo-binutils`).
- **No serial debug output**: confirm the right port and baud rate, close other serial monitors, reset the board, and retry with `minicom -D /dev/ttyACM0 -b 115200` (or your detected port).

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

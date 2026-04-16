# Troubleshooting

- **USB permissions**: if flashing tools cannot access the device, confirm udev rules/group membership and reconnect the board.
- **Serial port access**: ensure your user can access `/dev/ttyUSB*` or `/dev/ttyACM*` (often via `dialout` group).
- **Device detection**: use `probe-rs list` for debug probes and `ls /dev/ttyUSB* /dev/ttyACM*` for serial devices.
- **`.hex` file too large**: remove unused imports/assets, simplify display animations, and prefer smaller helper modules; for Python, consider precompiled modules (`mpy-cross`) where appropriate.
- **Missing dependencies**: install required Python tooling in your venv (`pip install uflash`) and verify Rust target/tooling (`rustup target add thumbv7em-none-eabihf`, `cargo-binutils`).
- **No serial debug output**: confirm the right port and baud rate, close other serial monitors, reset the board, and retry with `minicom -D /dev/ttyACM0 -b 115200` (or your detected port).

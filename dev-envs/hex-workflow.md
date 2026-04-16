# `.hex` comparison, workflow, and troubleshooting

## Python vs Rust `.hex` build comparison

| Approach | Typical `.hex` size | Typical build time | Best use case |
| --- | --- | --- | --- |
| Python (official editor / `uflash`) | Usually larger (runtime + script in one `.hex`) | Often ~5-15s for CLI packaging after tooling is installed | Learning, quick prototyping, classrooms |
| Python (`mpy-cross` + `uflash`) | Slightly smaller app payloads in some projects | Moderate (~3-10s) | Growing Python projects needing optimizations |
| Rust (`cargo build` + `objcopy`) | Usually smaller and more performance-focused firmware images | Clean builds can be ~10-60s; incremental builds are usually faster | Performance, control, production-style embedded work |

## Beginner Python workflow

1. **Create**: write `main.py` with `from microbit import *`.
2. **Test locally (logic only)**: validate pure-Python helpers on your machine (for example parsing/math/state code).
3. **Build `.hex`**: use official editor download or `uflash main.py --output firmware.hex`.
4. **Flash**: copy `.hex` to `MICROBIT` drive.
5. **Debug**: monitor serial output with `minicom`, `screen`, or `picocom`.

## Troubleshooting

- **`.hex` file too large**: remove unused imports/assets, simplify display animations, and prefer smaller helper modules; for Python, consider precompiled modules (`mpy-cross`) where appropriate.
- **Missing dependencies**: install required Python tooling in your venv (`pip install uflash`) and verify Rust target/tooling (`rustup target add thumbv7em-none-eabihf`, `cargo-binutils`).
- **No serial debug output**: confirm the right port and baud rate, close other serial monitors, reset the board, and retry with `minicom -D /dev/ttyACM0 -b 115200` (or your detected port).

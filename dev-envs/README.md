# Development environments

This repository provides lightweight, modular, **micro:bit-specific** dev shells for Rust, Python, and a combined workflow.

## Documentation index

- [Available shells](./shells.md)
- [Building `.hex` files for Python](./python/build-hex.md)
- [Building `.hex` files for Rust](./rust/build-hex.md)
- [Flashing code](./flashing.md)
- [Linting & formatting](./linting.md)
- [Troubleshooting](./troubleshooting.md)
- [Example workflows](./workflows.md)
- [`.hex` comparison + beginner workflow + troubleshooting](./hex-workflow.md)

## Building with MicroPython

In the `microbit-python` shell, you can use MicroPython-native tooling:

```bash
nix develop .#microbit-python
```

- Compile Python bytecode with `micropython`/`mpy-cross`:

  ```bash
  mpy-cross main.py -o main.mpy
  ```

- Build MicroPython firmware `.hex` (from a MicroPython source checkout):

  ```bash
  make -C ports/nrf BOARD=MICROBIT
  # or for v2 boards:
  make -C ports/nrf BOARD=MICROBIT_V2
  ```

  This produces a firmware `.hex` you can copy to the mounted `MICROBIT` drive.

## MicroPython workflow example

```bash
# 1) Edit
$EDITOR main.py

# 2) Compile
mpy-cross main.py -o main.mpy

# 3) Flash firmware/.hex to the board (mass-storage mount method)
cp firmware.hex /path/to/MICROBIT/
```

If your board exposes serial REPL, use `mpremote`:

```bash
mpremote connect auto repl
```

## Common MicroPython imports

- `microbit`
- `machine`
- `neopixel`
- `music`
- `utime` / `time`
- `ustruct`
- `uos`

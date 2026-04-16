# MicroPython on micro:bit

Use the `microbit-python` shell for a full MicroPython-native workflow:

```bash
nix develop .#microbit-python
```

---

## Compiling Python to bytecode

Compile a `.py` file to MicroPython bytecode (`.mpy`) with `mpy-cross`:

```bash
mpy-cross main.py -o main.mpy
```

---

## Building firmware `.hex` from source

If you have cloned the [MicroPython source](https://github.com/micropython/micropython):

```bash
# micro:bit v1
make -C ports/nrf BOARD=MICROBIT

# micro:bit v2
make -C ports/nrf BOARD=MICROBIT_V2
```

This produces a firmware `.hex` you can copy to the mounted `MICROBIT` drive.

---

## Edit → Compile → Flash workflow

```bash
# 1) Write your code
$EDITOR main.py

# 2) Compile to bytecode (optional, for modules)
mpy-cross main.py -o main.mpy

# 3) Mount the board and copy the firmware
sudo mount /dev/sda ~/mnt/microbit
cp firmware.hex ~/mnt/microbit/
sudo umount /dev/sda
```

---

## Common MicroPython imports

| Module | Purpose |
|--------|---------|
| `microbit` | display, buttons, pins, accelerometer |
| `machine` | low-level hardware access |
| `neopixel` | addressable LEDs |
| `music` | tones and melodies |
| `utime` / `time` | timing helpers |
| `ustruct` | binary packing |
| `uos` | filesystem operations |

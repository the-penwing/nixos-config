# Building `.hex` files for Python

This is the recommended starting path if you are new to micro:bit development.

## Option 1: official micro:bit Python editor (easiest)

1. Open the official editor: <https://python.microbit.org/>
2. Write your code and click **Download**.
3. The editor generates a ready-to-flash `.hex` file.

This approach bundles your script with a compatible micro:bit MicroPython runtime.

## Option 2: `uflash` (CLI)

```bash
nix develop .#microbit-python
pip install uflash
uflash main.py --output firmware.hex
```

You can also flash directly:

```bash
uflash main.py
```

## Option 3: MicroPython compiler flow (`mpy-cross` + `uflash`)

Use this when you want to precompile modules for larger projects:

```bash
# compile module(s) to .mpy
mpy-cross lib/helpers.py

# then package your app to a .hex for micro:bit
uflash main.py --output firmware.hex
```

`mpy-cross` compiles Python modules, while `uflash` is used to produce the final `.hex`.

## Step-by-step beginner example

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

## Common micro:bit Python imports

- `from microbit import *` (display, buttons, accelerometer, pins, sleep)
- `import neopixel` (addressable LEDs)
- `import music` (tones and melodies)
- `import radio` (device-to-device messaging)
- `import speech` (speech synthesis on supported firmware builds)
- `import random` / `import utime` (helpers and timing)

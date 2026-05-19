# Available shells

All dev shells use bash with Starship prompt and shared QoL tooling.

Shared QoL tools available in every shell: `starship`, `fzf`, `ripgrep`, `fd`, `bat`, `eza`, `direnv`, `zoxide`.

## `default`

Enter:

```bash
nix develop .#default
```

Includes:
- `git`
- `rsync`

---

## `pawn-appetit`

Enter:

```bash
nix develop .#pawn-appetit
```

Includes:
- `cargo`, `rustc`
- `nodejs`, `pnpm`
- `pkg-config`, `gtk3`, `webkitgtk_4_1`, `libsoup_3`

---

## `microbit-python`

Enter:

```bash
nix develop .#microbit-python
```

Includes:
- `python3`
- `pip`
- `uv`
- `micropython` (includes `mpy-cross`)
- `gcc`, `gcc-arm-embedded`, `gnumake`, `pkg-config`
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

## `microbit-rust`

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
- `probe-rs-tools`, `openocd`
- `rustfmt`
- `cargo-expand`, `cargo-bloat`
- `clippy` (installed via `rustup component add clippy` in shell hook)

Example:

```bash
cargo build
cargo watch -x check
```

---

## `microbit` (combined)

Enter:

```bash
nix develop .#microbit
```

Includes all tools from both `microbit-python` and `microbit-rust`.

---

## `bash-scripting`

Enter:

```bash
nix develop .#bash-scripting
```

Includes:
- `bashInteractive`
- `bash-completion`
- `shellcheck`
- `shfmt`
- `bats`
- `bash-language-server`
- `jq`, `yq-go`

QoL behavior in shell hook:
- Starship prompt
- `zoxide` init for smart directory jumps (`cd` aliased to `z`)
- Modern CLI aliases (`ls/eza`, `cat/bat`, `grep/rg`, etc.)

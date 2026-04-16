# Available shells

All dev shells launch `zsh -l` for interactive sessions, so your regular `~/.zshrc` setup (Oh My Zsh, plugins, aliases, Starship prompt) is loaded automatically.

Shared shell QoL tools available in every shell: `starship`, `fzf`, `ripgrep`, `fd`, `bat`, `eza`, `direnv`, `zoxide`.

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
- `gcc`, `gnumake`, `pkg-config`
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

## `microbit` (combined)

Enter:

```bash
nix develop .#microbit
```

Includes all tools from both `microbit-python` and `microbit-rust`.

# Development environments

This repository provides lightweight, modular, **micro:bit-specific** dev shells.

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

Includes both `microbit-python` and `microbit-rust` toolsets.

## Adding project-specific dependencies

Keep these base shells lightweight. For project-specific tools, create a local `flake.nix` in your project directory and extend only what that project needs.

### 1) Rust micro:bit project (`cargo-embed`, `probe-rs`)

Create `/path/to/your/project/flake.nix`:

```nix
{
  description = "micro:bit Rust project shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    main-config.url = "github:the-penwing/nixos-config";
  };

  outputs = { self, nixpkgs, main-config, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      base = main-config.devShells.${system}.microbit-rust;
    in {
      devShells.${system}.default = pkgs.mkShell {
        inputsFrom = [ base ];
        packages = with pkgs; [
          cargo-embed
          probe-rs
        ];
      };
    };
}
```

### 2) Python micro:bit project (`esptool`, `minicom`)

Create `/path/to/your/project/flake.nix`:

```nix
{
  description = "micro:bit Python project shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    main-config.url = "github:the-penwing/nixos-config";
  };

  outputs = { self, nixpkgs, main-config, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      base = main-config.devShells.${system}.microbit-python;
    in {
      devShells.${system}.default = pkgs.mkShell {
        inputsFrom = [ base ];
        packages = with pkgs; [
          esptool
          minicom
        ];
      };
    };
}
```

### 3) Usage from an external project directory

```bash
mkdir -p ~/dev/hardware/microbit/blink-rust
cd ~/dev/hardware/microbit/blink-rust
# create flake.nix from one of the examples above
nix develop
# (If you see `nix flake develop` in older examples, use `nix develop` instead.)
```

Customize dependencies per project by editing only that project's `packages` list in `flake.nix`.

### 4) Recommended structure for multiple projects

```text
~/dev/hardware/microbit/
├── blink-rust/
│   ├── flake.nix      # extends microbit-rust + cargo-embed/probe-rs
│   ├── Cargo.toml
│   └── src/
├── sensor-python/
│   ├── flake.nix      # extends microbit-python + esptool/minicom
│   └── main.py
└── shared-notes/
    └── README.md
```

This keeps each project self-contained and the main NixOS config in this repository untouched.

### Common setup patterns / best practices

- Keep `dev-envs` shells in this repo minimal and reusable.
- Put project-specific tools in each project's own `flake.nix`.
- Use `inputsFrom = [ base ];` to inherit from `microbit-python` or `microbit-rust`.
- Pin/update dependencies per project (`nix flake lock --update-input nixpkgs`) without affecting other projects.

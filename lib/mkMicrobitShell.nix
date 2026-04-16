{ pkgs }:
let
  mkDevShell = import ./mkDevShell.nix { inherit pkgs; };
in
{
  python ? false,
  rust ? false,
  shellMessage,
  includeVenvHint ? false,
}:
let
  pythonInputs = with pkgs; [
    python3
    python3Packages.pip
    uv
    micropython
    gcc
    gnumake
    pkg-config
    esptool
    minicom
    screen
    picocom
    ruff
    black
    mypy
    python3Packages.ipython
  ];

  rustInputs = with pkgs; [
    rustup
    cargo
    rustc
    rust-analyzer
    cargo-watch
    probe-rs-tools
    openocd
    rustfmt
    cargo-expand
    cargo-bloat
  ];
in
mkDevShell {
  buildInputs =
    (if python then pythonInputs else [ ])
    ++ (if rust then rustInputs else [ ]);

  shellHook = ''
    echo "${shellMessage}"
    ${if includeVenvHint then ''echo "Use: python3 -m venv .venv && source .venv/bin/activate"'' else ""}
    ${if rust then ''rustup component add clippy >/dev/null 2>&1 || true'' else ""}
  '';
}

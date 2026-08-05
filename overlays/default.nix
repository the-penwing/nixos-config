# Overlays collection.
# Keep this list minimal — prefer declarative home-manager config when possible.
[
  (final: prev: {
    # REVIEW: drop once
    # https://github.com/NixOS/nixpkgs/pull/549253
    # lands on nixos-unstable
    hyprland = prev.hyprland.overrideAttrs (oldAtters: {
      postPatch =
        ''
          # Relax glaze dependency
          # FIXME: this shouldn't be needed once the upstream code will adopt it
          substituteInPlace CMakeLists.txt start/CMakeLists.txt hyprpm/CMakeLists.txt \
           --replace-fail "glaze 7...<8" "glaze"
        ''
        + (oldAtters.postPatch or "");
    });
  })
]

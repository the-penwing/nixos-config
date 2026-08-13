# Overlays collection.
# Keep this list minimal — prefer declarative home-manager config when possible.
[
  (final: prev: {
    ananicy-cpp = prev.ananicy-cpp.overrideAttrs (old: {
      postPatch =
        (old.postPatch or "")
        + ''
          find src -name '*.cpp' -exec sed -i '1i #include <cstdint>\n#include <cstring>\n#include <cerrno>' {} +
        '';
    });
  })
]

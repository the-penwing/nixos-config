# Overlay collection for this repository.
#
# Keep all package overrides here so modules stay declarative and simple.
[
  (final: prev: {
    qutebrowser = prev.qutebrowser.override { enableWideVine = true; };
  })
]

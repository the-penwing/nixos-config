# Overlays collection.
#
# qutebrowser: Enable Widevine support for DRM video playback (Netflix, etc.)
# Keep this list minimal — prefer declarative home-manager config when possible.
[
  (final: prev: {
    qutebrowser = prev.qutebrowser.override { enableWideVine = true; };
  })
]

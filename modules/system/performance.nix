# Performance and resource management settings.
#
# Purpose:
# - Prioritise interactive responsiveness on laptop hardware
# - Keep memory pressure and build pressure predictable
{pkgs, ...}: {
  zramSwap = {
    enable = true;
    memoryPercent = 100;
    algorithm = "zstd";
    priority = 100;
  };

  systemd.oomd.enable = false;

  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-cpp;
    settings.apply_nice = true;
  };

  services.fstrim.enable = true;

  # Avoid boot delays from network-online wait units when not required.
  systemd.services.NetworkManager-wait-online.enable = false;
}

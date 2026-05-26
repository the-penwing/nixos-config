# Performance and resource management settings.
#
# Purpose:
# - Prioritise interactive responsiveness on laptop hardware
# - Keep memory pressure and build pressure predictable
{ pkgs, ... }:

{
  zramSwap = {
    enable = true;
    memoryPercent = 100;
    algorithm = "zstd";
    priority = 100;
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 20;
    "vm.vfs_cache_pressure" = 50;
    "vm.dirty_ratio" = 15;
    "vm.dirty_background_ratio" = 5;
  };

  systemd.oomd.enable = false;

  # Keep UI responsive during local Nix builds.
  nix.settings = {
    cores = 4;
    max-jobs = 2;
  };

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

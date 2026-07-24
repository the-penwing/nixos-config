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

  boot.kernel.sysctl = {
    "vm.swappiness" = 20;
    "vm.vfs_cache_pressure" = 50;
    "vm.dirty_ratio" = 15;
    "vm.dirty_background_ratio" = 5;
  };

  systemd.oomd.enable = false;

  # Keep UI responsive during local Nix builds.
  nix.settings = {
    cores = 10;
    max-jobs = 4;
  };

  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-cpp;
    settings.apply_nice = true;
  };

  programs.ccache.enable = true;

  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "6G";

  services.tlp = {
    enable = true;
    settings = {
      AMD_ENERGY_PERF_POLICY_ON_BAT = "power";
      PLATFORM_PROFILE_ON_BAT = "low-power";
      CPU_BOOST_ON_BAT = 0;
      AMD_ENERGY_PERF_POLICY_ON_AC = "performance";
      PLATFORM_PROFILE_ON_AC = "performance";
      CPU_BOOST_ON_AC = 1;
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;

      USB_AUTOSUSPEND = 1;

      WIFI_PWR_ON_BAT = "on";
      WIFI_PWR_ON_AC = "off";

      RUNTIME_PM_DENYLIST = "02:00.0 05:00.0";
      SOUND_POWER_SAVE_ON_BAT = 1;
      SOUND_POWER_SAVE_CONTROLLER = "Y";

      SATA_LINKPWR_ON_AC = "med_power_with_dipm";
      SATA_LINKPWR_ON_BAT = "med_power_with_dipm";
    };
  };

  services.power-profiles-daemon.enable = false;

  services.fstrim.enable = true;

  # Avoid boot delays from network-online wait units when not required.
  systemd.services.NetworkManager-wait-online.enable = false;
}

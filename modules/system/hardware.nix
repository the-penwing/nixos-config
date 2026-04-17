{ pkgs, ... }:
{
  # Disable broken touchscreen
  services.udev.extraRules = ''
    SUBSYSTEM=="input", ATTRS{name}=="ELAN2513:00 04F3:23E9", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.pipewire.extraConfig.pipewire."10-clock" = {
    "context.properties" = {
      "default.clock.rate" = 48000;
      "default.clock.quantum" = 1024;
      "default.clock.min-quantum" = 32;
      "default.clock.max-quantum" = 8192;
    };
  };

  # Printing
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brlaser ];

  # Bluetooth
  hardware.bluetooth.enable = true;

  # Performance: Compressed RAM-based swap, faster than disk
  zramSwap = {
    enable = true;
    memoryPercent = 150;  # 1.5x RAM as virtual memory
    algorithm = "zstd";    # Best compression ratio
    priority = 100;        # Prefer zram over disk swap
  };

  # Memory management tuning
  boot.kernel.sysctl = {
    "vm.swappiness" = 20;              # Prefer cache over swap
    "vm.vfs_cache_pressure" = 50;      # Less aggressive cache reclaim
    "vm.dirty_ratio" = 15;             # fsync more frequently
    "vm.dirty_background_ratio" = 5;   # background writeback earlier
  };

  # Use kernel OOM killer (MGLRU), not systemd-oomd
  systemd.oomd.enable = false;

  # Nix builder tuning: leave cores for UI
  nix.settings = {
    cores = 4;      # Don't max out all 8
    max-jobs = 2;   # Limit parallel builds
  };

  # Auto process priority management
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-cpp;
    settings.apply_nice = true;
  };
}

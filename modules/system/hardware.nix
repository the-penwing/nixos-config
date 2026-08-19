# Hardware-specific runtime support.
#
# Purpose:
# - Keep hardware enablement separate from service and package concerns
{pkgs, ...}: {
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
      "default.clock.min-quantum" = 512;
      "default.clock.max-quantum" = 8192;
    };
  };

  hardware.graphics = {
    enable = true;
    extraPackages = [
      pkgs.mesa.opencl
    ];
  };

  hardware.bluetooth.enable = true;

  hardware.acpilight = {
    enable = true;
  };

  services.udev.extraRules = ''
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2e8a", MODE="0666", TAG+="uaccess"

    # Securely point directly to the Nix store binaries so the sandbox validator passes
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl1", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
  '';
}

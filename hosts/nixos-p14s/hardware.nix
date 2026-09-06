{pkgs, ...}: {
  hardware.amdgpu.initrd.enable = true;

  hardware.acpilight.enable = true;

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl1", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
  '';
}

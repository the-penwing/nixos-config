{pkgs, ...}: {
  hardware.amdgpu.initrd.enable = true;

  hardware.acpilight.enable = true;

  services.udev.extraRules = ''
    SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl1", GROUP="video", MODE="0664"
  '';
}

# Bootloader and kernel selection.
#
# Purpose:
# - Keep host boot policy explicit and minimal
{pkgs, ...}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.supportedFilesystems = [
    "exfat"
    "ntfs"
    "vfat"
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = [
      pkgs.mesa.opencl
    ];
  };

  environment.sessionVariables = {
    RUSTICL_ENABLE = "radeonsi";
  };
}

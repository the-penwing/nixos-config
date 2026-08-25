# Bootloader and kernel selection.
#
# Purpose:
# - Keep host boot policy explicit and minimal
{pkgs, ...}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernelParams = [
    "amd_pstate=active"
    "amdgpu.dcfeaturemask=0x2"
  ];

  boot.supportedFilesystems = [
    "exfat"
    "ntfs"
    "vfat"
  ];

  boot.kernel.sysctl = {
    "vm.swappiness" = 20;
    "vm.vfs_cache_pressure" = 50;
    "vm.dirty_ratio" = 15;
    "vm.dirty_background_ratio" = 5;
  };

  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "6G";
  system.activationScripts.text = ''
    ln -sf ${pkgs.bash}/bin/bash /bin/bash
  '';
}

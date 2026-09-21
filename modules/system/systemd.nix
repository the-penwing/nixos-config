{pkgs, ...}: {
  systemd.tmpfiles.rules = [
    "d /var/lib/pcsc 0755 pcscd pcscd - -"
    "d /var/lib/pcsc/drivers 0755 pcscd pcscd - -"
    "L /var/lib/pcsc/drivers/ifd-ccid.bundle - - - - ${pkgs.ccid}/pcsc/drivers/ifd-ccid.bundle"
  ];
}

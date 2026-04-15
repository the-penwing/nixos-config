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
}

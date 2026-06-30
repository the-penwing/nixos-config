# Hardware-specific runtime support.
#
# Purpose:
# - Keep hardware enablement separate from service and package concerns
{...}: {
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

  hardware.bluetooth.enable = true;

  services.udev.extraRules = ''
    # Pico HSM Device Access
    # Allow user access to Pico HSM without sudo
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="10fd", MODE="0666"
  '';
}

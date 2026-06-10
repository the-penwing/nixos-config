# Networking and locale defaults for nixos-p14s.
#
# Security notes:
# - Keep OpenSSH disabled (Tailscale SSH is preferred)
# - Keep firewall explicitly enabled and only open ports required for known tools
{ ... }:

{
  networking = {
    hostName = "nixos-p14s";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 1337 8000 22000 47984 47989 47990 48010 ];
      allowedUDPPortRanges = [
        { from = 8000; to = 8010; }
        { from = 47900; to = 48000; }
      ];
    };
    nameservers = [ "192.168.50.117" "1.1.1.1" ];
    search = [ "homelab" ];
  };

  services.openssh.enable = false;

  time.timeZone = "Australia/Sydney";
  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };
}

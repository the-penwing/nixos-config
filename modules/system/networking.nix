# modules/system/networking.nix
# Networking and locale defaults for nixos-p14s.
#
# Security notes:
# - Keep OpenSSH disabled (Tailscale SSH is preferred)
# - Keep firewall explicitly enabled and only open ports required for known tools
{...}: {
  networking = {
    hostName = "nixos-p14s";
    networkmanager.enable = false;

    wireless.iwd = {
      enable = true;
      settings = {
        General.EnableNetworkConfiguration = true;
      };
    };

    useDHCP = false;
    interfaces.enp2s0f0.useDHCP = true;
    interfaces.enp5s0.useDHCP = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443
        8443
        8080
        8000
        3000
        47984 # Sunshine
        47989 # Sunshine
        48010 # Sunshine
      ];
      # All Sunshine
      allowedUDPPorts = [
        47998
        47999
        48000
        48002
        48010
      ];
    };
  };

  services.resolved = {
    enable = true;
    extraConfig = ''
      DNS=192.168.50.117
      Domains=~homelab
    '';
  };

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

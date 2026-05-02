{ ... }:

{
  networking = {
    hostName = "nixos-laptop";
    networkmanager.enable = true;
    # Port 22 (SSH) removed — OpenSSH disabled, Tailscale SSH used instead
    # Port 8000 removed — unused
    firewall.allowedTCPPorts = [ 47984 47989 47990 48010 ];
    firewall.allowedUDPPortRanges = [
      { from = 47900; to = 48000; }
      { from = 8000; to = 8010; }
    ];  
  };

  time.timeZone = "Australia/Sydney";
  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT    = "en_AU.UTF-8";
    LC_MONETARY       = "en_AU.UTF-8";
    LC_NAME           = "en_AU.UTF-8";
    LC_NUMERIC        = "en_AU.UTF-8";
    LC_PAPER          = "en_AU.UTF-8";
    LC_TELEPHONE      = "en_AU.UTF-8";
    LC_TIME           = "en_AU.UTF-8";
  };
}

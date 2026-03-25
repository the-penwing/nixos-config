{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # ============================================================
  # NIX SETTINGS
  # ============================================================
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # ============================================================
  # BOOT
  # ============================================================
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # ============================================================
  # NETWORKING
  # ============================================================
  networking = {
  	hostName = "bens-nixos-laptop";
  	networkmanager.enable = true;
  };
  security.pki.certificateFiles = [ ./root.crt ];

  # ============================================================
  # LOCALE & TIME
  # ============================================================
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

  # ============================================================
  # DESKTOP — Cinnamon + LightDM (Hyprland also available)
  # ============================================================
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.cinnamon.enable = true;
    xkb = {
      layout = "au";
      variant = "";
    };
  };

  programs.hyprland.enable = true;

  # ============================================================
  # HARDWARE
  # ============================================================

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
    # jack.enable = true;
  };

  # Printing
  services.printing.enable = true;

  # ============================================================
  # SERVICES
  # ============================================================
  services.tailscale.enable = true;
  services.flatpak.enable = true;
  services.dbus.enable = true;
  services.solaar = {
    enable = true; # Enable the service
    package = pkgs.solaar; # The package to use
    window = "hide"; # Show the window on startup (show, *hide*, only [window only])
    batteryIcons = "regular"; # Which battery icons to use (*regular*, symbolic, solaar)
    extraArgs = ""; # Extra arguments to pass to solaar on startup
  };
  
  # ============================================================
  # PROGRAMS
  # ============================================================
  programs.firefox.enable = true;
  programs.zsh.enable = true;
  
  # ============================================================
  # VIRTUALISATION
  # ============================================================
  virtualisation.docker.enable = true;
  
  # ============================================================
  # USER
  # ============================================================
  users.users.benvl = {
    isNormalUser = true;
    description = "Ben van Leeuwen";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "video" "input" "docker" ];
  };

  # ============================================================
  # PACKAGES
  # ============================================================
  environment.systemPackages = with pkgs; [
    # Creative
    gimp
    inkscape
    krita
    
    # Audio
    easyeffects
    mpv
  
    # Utilities
    bitwarden-desktop
    discord
    vlc
    gnome-software
    syncthing
    syncthingtray
    
    # Terminal & Editor
    ghostty
    neovim
    micro

    # Browser & Office
    libreoffice
    obsidian  
    xournalpp
  

    # File Manager
    nautilus

    # Dev tools
    git
    python3
    nodejs
    rustup
    sassc
    tailscale-systray
    lazygit
    tea
    pyenv
    uv
    sqlitebrowser
        
    # Virtualisation
    docker-compose

    # CLI utilities
    wget
    curl
    unzip
    zip
    fzf
    fd
    btop
    fastfetch
    tree
    ripgrep
    bat
    eza
    duf
    dust
    tldr
    jq

    # Screenshot (Hyprland)
    grim
    slurp

    # Hyprland extras
    waybar
    wofi
    hyprpaper
    hyprlock
    dunst

    # System
    networkmanagerapplet
    brightnessctl
    pamixer
    bamf
  ];

  programs.nix-ld.enable = true;

  # ============================================================
  # FONTS
  # ============================================================
  fonts.packages = with pkgs; [
    nerd-fonts._0xproto
    nerd-fonts.fira-code
  ];

  # ============================================================
  # DO NOT CHANGE
  # ============================================================
  system.stateVersion = "25.11";
}

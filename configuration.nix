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
    hostName = "nixos-laptop";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 22 8000 ];
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
  # DESKTOP — Cinnamon kept as fallback, Hyprland is primary
  # ============================================================
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.cinnamon.enable = true;  # Keep as fallback
    xkb = {
      layout = "au";
      variant = "";
    };
  };

  # Hyprland (Wayland)
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Hyprlock & Hypridle — declarative
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  # XDG desktop portals
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    config.common.default = [ "hyprland" "gtk" ];
  };

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

  # ============================================================
  # SERVICES
  # ============================================================
  services.tailscale.enable = true;
  services.flatpak.enable = true;
  programs.thunderbird.enable = true;
  services.dbus.enable = true;
  services.solaar = {
    enable = true;
    package = pkgs.solaar;
    window = "hide";
    batteryIcons = "regular";
    extraArgs = "";
  };
  services.syncthing = {
    enable = true;
    user = "benvl";
    dataDir = "/home/benvl/.local/share/syncthing";
    openDefaultPorts = true;
  };
  services.openssh = {
  	enable = true;
  	settings = {
  	  PermitRootLogin = "no";
  	};
  };
  # Polkit (needed for auth dialogs in Hyprland)
  security.polkit.enable = true;

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
    f3d
    aseprite

    # Audio
    easyeffects
    mpv

    # Utilities
    bitwarden-desktop
    discord
    vlc
    gnome-software
    imv
    kdePackages.k3b
    ollama
    chatbox
    jellyfin-desktop
    
    # Terminal & Editor
    ghostty
    neovim
    micro

    # Games
    mgba
    
    # Browser & Office
    libreoffice
    obsidian
    xournalpp
    kiwix

    # File Manager (Nautilus — no Nemo!)
    nautilus
    nautilus-python  # Extensions support

    # Dev tools
    git
    python3
    nodejs
    rustup
    sassc
    lazygit
    tea
    pyenv
    uv
    sqlitebrowser
    starship
    filezilla

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
    screenfetch
    fastfetch
    tree
    ripgrep
    bat
    eza
    duf
    dust
    tldr
    jq
    imagemagick
    tmux

    # Screenshot (Hyprland/Wayland)
    grim
    slurp
    swappy  # Screenshot editor

    # Wayland clipboard
    wl-clipboard
    cliphist

    # Hyprland ecosystem
    waybar
    wofi
    hyprpaper
    hyprlock
    dunst
    hypridle
    hyprpolkitagent
    nwg-displays
    nwg-look
    wlogout
    playerctl
    bibata-cursors
    rofi
    nwg-dock-hyprland
    networkmanager_dmenu    
    
    # Qt theming (for non-GTK apps under Hyprland)
    qt6Packages.qt6ct
    qt6Packages.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugins

    # Brightness & audio controls
    brightnessctl
    pamixer
    pavucontrol

    # GTK / icon themes (Gruvbox)
    gruvbox-dark-gtk           # GTK theme
    gruvbox-plus-icons         # Icon pack

    # Polkit agent
    polkit_gnome

    # System / misc
    networkmanagerapplet
    bamf
    libheif
    xdg-utils
    usbmuxd2
    
    # Wayland compatibility
    xwayland
    waypaper
  ];

  programs.nix-ld.enable = true;

  # ============================================================
  # FONTS
  # ============================================================
  fonts.packages = with pkgs; [
    nerd-fonts._0xproto
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.envy-code-r
    cantarell-fonts           # GTK default font
  ];

  # ============================================================
  # DO NOT CHANGE
  # ============================================================
  system.stateVersion = "25.11";
}

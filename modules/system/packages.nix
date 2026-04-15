{ pkgs, ... }:

{
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
    inkscape
    krita
    f3d
    aseprite
    oculante
    feh

    # Audio & Video
    easyeffects
    mpv
    vlc
    kdePackages.k3b
    jellyfin-desktop
    feishin
    tuxguitar
    stremio-linux-shell

    # Utilities
    bitwarden-desktop
    discord
    imv
    ollama

    # Terminal & Editor
    ghostty
    neovim
    micro
    vscodium

    # Games
    mgba
    prismlauncher
    retroarch
    
    # Browser & Office
    libreoffice
    obsidian
    kiwix

    # File Manager (Nautilus — no Nemo!)
    nautilus
    nautilus-python  # Extensions support

    # Dev tools
    git
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
    swww
    
    # Qt theming (for non-GTK apps under Hyprland)
    qt6Packages.qt6ct
    qt6Packages.qtstyleplugin-kvantum
    
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
    blueman
    libheif
    xdg-utils
    libimobiledevice
    ifuse
    
    # Wayland compatibility
    xwayland
    waypaper
  ];

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
}

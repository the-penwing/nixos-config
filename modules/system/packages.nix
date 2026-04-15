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

    # ── Creative ───────────────────────────────────────────────
    inkscape        # Vector graphics (occasional use)
    aseprite        # Pixel art editor
    oculante        # Fast image viewer
    feh             # Minimal image viewer / wallpaper setter

    # ── Audio & Video ──────────────────────────────────────────
    mpv             # Video player
    vlc             # Media player
    kdePackages.k3b # CD/DVD burner (occasional)
    tuxguitar       # Guitar tablature editor

    # ── Productivity & Office ──────────────────────────────────
    libreoffice     # Office suite (school essential)
    obsidian        # Note-taking (essential)
    bitwarden-desktop # Password manager (security backup)

    # ── Communication & Social ─────────────────────────────────
    discord

    # ── AI & Misc Utilities ────────────────────────────────────
    ollama          # Local LLM inference

    # ── Terminal & Editor ──────────────────────────────────────
    ghostty         # Terminal emulator
    neovim          # Primary editor
    micro           # Fallback terminal editor

    # ── Games ──────────────────────────────────────────────────
    prismlauncher   # Minecraft launcher

    # ── File Manager ───────────────────────────────────────────
    nautilus        # GUI file manager (occasional use)
    nautilus-python # Nautilus extensions support

    # ── Dev Tools ──────────────────────────────────────────────
    git             # Version control (essential)
    sqlitebrowser   # SQLite GUI (handy when needed)
    starship        # Shell prompt
    filezilla       # FTP/SFTP client (home server access)

    # ── CLI Utilities ──────────────────────────────────────────
    wget            # File downloader
    curl            # HTTP client
    unzip           # Archive extraction
    zip             # Archive creation
    fzf             # Fuzzy finder
    fd              # Fast find replacement
    btop            # System monitor (also aliased as ps)
    screenfetch     # System info
    fastfetch       # Fast system info
    tree            # Directory tree viewer
    ripgrep         # Fast grep replacement
    bat             # Better cat with syntax highlighting
    eza             # Better ls with icons/colours
    duf             # Better df / disk usage overview
    dust            # Better du / directory size analyser
    tldr            # Command cheatsheets
    jq              # JSON processor
    imagemagick     # Image manipulation
    tmux            # Terminal multiplexer

    # ── Screenshot (Hyprland / Wayland) ────────────────────────
    grim            # Screenshot tool
    slurp           # Interactive region selector
    swappy          # Screenshot annotation/editor

    # ── Wayland Clipboard ──────────────────────────────────────
    wl-clipboard    # Clipboard read/write
    cliphist        # Clipboard history daemon

    # ── Hyprland Ecosystem ─────────────────────────────────────
    waybar          # Status bar
    wofi            # App launcher
    hyprpaper       # Wallpaper daemon
    hyprlock        # Lock screen
    dunst           # Notification daemon
    hypridle        # Idle / DPMS daemon
    hyprpolkitagent # Polkit authentication dialogs
    nwg-displays    # Display configuration GUI
    nwg-look        # GTK theme manager
    wlogout         # Logout / power menu
    playerctl       # MPRIS media control
    bibata-cursors  # Cursor theme
    rofi            # Alternative launcher
    nwg-dock-hyprland # Dock
    networkmanager_dmenu # Network selection menu
    swww            # Animated wallpaper daemon
    waypaper        # Wallpaper picker GUI

    # ── Qt Theming ─────────────────────────────────────────────
    qt6Packages.qt6ct                  # Qt theme configuration tool
    qt6Packages.qtstyleplugin-kvantum  # Kvantum style engine

    # ── Brightness & Audio Controls ────────────────────────────
    brightnessctl   # Backlight control
    pamixer         # PulseAudio CLI mixer
    pavucontrol     # PulseAudio GUI mixer

    # ── GTK / Icon Themes (Gruvbox) ────────────────────────────
    gruvbox-dark-gtk   # GTK theme
    gruvbox-plus-icons # Icon pack

    # ── Polkit Agent ───────────────────────────────────────────
    polkit_gnome    # Auth agent for Hyprland

    # ── System / Misc ──────────────────────────────────────────
    networkmanagerapplet # Network tray applet
    bamf            # Window matcher (for docks)
    blueman         # Bluetooth manager
    libheif         # HEIF/HEIC image codec
    xdg-utils       # XDG desktop integration helpers
    libimobiledevice # iOS device support
    ifuse           # Mount iOS filesystems

    # ── Wayland / X11 Compatibility ────────────────────────────
    xwayland        # X11 app compatibility layer
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

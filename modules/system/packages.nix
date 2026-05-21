{ pkgs, ... }:

{
  # ================================================================================================
  # USER
  # ================================================================================================
  users.users.benvl = {
    isNormalUser = true;                  # Normal user account
    description = "Ben van Leeuwen";      # User description
    shell = pkgs.zsh;                     # Default shell
    extraGroups = [                       # Supplementary groups
      "docker"
      "input"
      "networkmanager"
      "plugdev"
      "plocate"
      "video"
      "wheel"
    ];
  };

  # ================================================================================================
  # PACKAGES
  # ================================================================================================
  environment.systemPackages = with pkgs; [

    # ── Creative ──────────────────────────────────────────────────────────────────────────────────
    aseprite                              # Pixel art editor
    feh                                   # Minimal image viewer and wallpaper setter
    imagemagick                           # Image conversion and manipulation tools
    oculante                              # Fast image viewer

    # ── Audio & Video ─────────────────────────────────────────────────────────────────────────────
    ffmpeg                                # Audio/video toolkit
    sunshine                              # Game streaming host for Moonlight
    vlc                                   # Media player

    # ── Productivity & Office ─────────────────────────────────────────────────────────────────────
    bitwarden-desktop                     # Password manager
    libreoffice-fresh                     # Office suite
    obsidian                              # Notes and knowledge base
    qutebrowser                           # Keyboard-driven browser
    zathura                               # PDF viewer
    zathuraPkgs.zathura_pdf_poppler       # Zathura PDF backend (Poppler)
    sc-im                                 # Ncurses spreadsheet program for terminal

    # ── Diagramming & Visualisation ───────────────────────────────────────────────────────────────
    drawio                                # Diagramming tool
    gephi                                 # Graph visualization tool
    graphviz                              # Graph visualization suite
    mermaid-cli                           # Mermaid diagram generator
    yed                                   # Graph editor and visualizer

    # ── Communication & Social ────────────────────────────────────────────────────────────────────
    discord                               # Chat and voice client

    # ── AI & Misc Utilities ───────────────────────────────────────────────────────────────────────
    github-copilot-cli                    # GitHub Copilot CLI
    copilot-language-server               # Copilot language server

    # ── Terminal & Editor ─────────────────────────────────────────────────────────────────────────
    ghostty                               # Terminal emulator
    neovim                                # Primary editor
    starship                              # Cross-shell prompt
    tmux                                  # Terminal multiplexer
    vim                                   # Fallback terminal editor

    # ── File Managers ─────────────────────────────────────────────────────────────────────────────
    thunar                                # Lightweight GTK file manager

    # ── Dev Tools ─────────────────────────────────────────────────────────────────────────────────
    arduino-cli                           # Arduino CLI
    arduino-ide                           # Arduino IDE
    filezilla                             # GUI FTP client
    git                                   # Version control
    gucharmap                             # Character map utility
    lftp                                  # CLI FTP client
    samba                                 # SMB client utilities
    smbclient-ng                          # SMB client with extras
    sqlitebrowser                         # SQLite GUI browser
    sqlite                                # SQL database engine

    # ── Programming Languages & Toolchains ────────────────────────────────────────────────────────
    lua54Packages.lua                     # Lua runtime
    lua54Packages.luarocks                # A package manager for Lua modules
    lua-language-server                   # Lua language server
    lua54Packages.luacheck                # Lua linter
    stylua                                # Lua formatter
    rust-analyzer                         # Rust language server
    rustup                                # Rust toolchain manager

    # ── CLI Utilities ─────────────────────────────────────────────────────────────────────────────
    bat                                   # Cat with syntax highlighting
    bottom                                # TUI system monitor
    btop                                  # System monitor (htop-like)
    cloc                                  # Count lines of code
    cmatrix                               # Matrix-style terminal effect
    curl                                  # HTTP client
    duf                                   # Disk usage overview
    dust                                  # Directory size analyzer
    eza                                   # Enhanced ls with icons
    fastfetch                             # System info summary
    fd                                    # Find replacement
    file                                  # File type identification
    fzf                                   # Fuzzy finder
    gdu                                   # Disk usage analyzer (TUI)
    glow                                  # Markdown renderer
    jq                                    # JSON processor
    ripgrep                               # Fast grep
    tldr                                  # Simplified man pages
    tree                                  # Directory tree viewer
    unzip                                 # Extract zip archives
    wget                                  # File downloader
    zip                                   # Create zip archives

    # ── Screenshot (Hyprland / Wayland) ───────────────────────────────────────────────────────────
    grim                                  # Screenshot tool
    slurp                                 # Region selector
    swappy                                # Screenshot editor

    # ── Wayland Clipboard ─────────────────────────────────────────────────────────────────────────
    cliphist                              # Clipboard history
    wl-clipboard                          # Wayland clipboard tools

    # ── Hyprland Ecosystem ────────────────────────────────────────────────────────────────────────
    bibata-cursors                        # Cursor theme
    hyprpolkitagent                       # Polkit authentication agent
    nwg-displays                          # Display configuration GUI
    nwg-look                              # GTK theme manager
    playerctl                             # Media player control
    power-profiles-daemon                 # Power profile manager
    upower                                # Power management service
    wlr-randr                             # Wayland output management

    # ── Qt Theming ────────────────────────────────────────────────────────────────────────────────
    dracula-qt5-theme                     # Dracula theme for Qt5
    qt6Packages.qt6ct                     # Qt6 configuration tool
    qt6Packages.qtstyleplugin-kvantum     # Kvantum style engine

    # ── Brightness & Audio Controls ───────────────────────────────────────────────────────────────
    brightnessctl                         # Backlight control
    pamixer                               # PulseAudio CLI mixer
    pavucontrol                           # PulseAudio volume control GUI

    # ── GTK / Icon Themes (Dracula) ───────────────────────────────────────────────────────────────
    dracula-icon-theme                    # Dracula icon pack
    dracula-theme                         # GTK theme

    # ── Polkit Agent ──────────────────────────────────────────────────────────────────────────────
    polkit_gnome                          # Polkit agent (GTK)

    # ── System / Misc ─────────────────────────────────────────────────────────────────────────────
    bamf                                  # Window matcher for docks
    blueman                               # Bluetooth manager
    ifuse                                 # Mount iOS devices
    libheif                               # HEIF/HEIC codec library
    libimobiledevice                      # iOS device support
    usbutils                              # USB utilities (lsusb)
    xdg-utils                             # XDG desktop helpers

    # ── Security / Ethical Hacking Lab ────────────────────────────────────────────────────────────
    # Core networking + isolated lab infra
    cacert                                # CA certificate bundle
    inetutils                             # Basic network utilities
    netcat                                # TCP/UDP networking tool
    openvpn                               # VPN client and server
    openssl                               # TLS/crypto toolkit
    proxychains-ng                        # Proxy wrapper for apps
    rlwrap                                # Readline wrapper for CLIs
    virt-manager                          # Virtual machine manager
    # Recon, scanning, and enumeration
    ffuf                                  # Web fuzzing tool
    feroxbuster                           # Web content discovery
    gobuster                              # Directory/file brute force
    nmap                                  # Network scanner
    rustscan                              # Fast port scanner
    whatweb                               # Web tech fingerprinting
    # Web application testing
    burpsuite                             # Web security testing suite
    sqlmap                                # SQL injection testing
    wpscan                                # WordPress scanner
    # Active Directory / internal network ops
    bloodhound-py                         # BloodHound data collector
    enum4linux-ng                         # SMB/AD enumeration
    python312Packages.impacket            # Network protocol toolkit
    smbmap                                # SMB share enumeration
    # Tunneling and traffic analysis
    chisel                                # TCP tunneling tool
    tcpdump                               # Packet capture
    wireshark                             # Packet analyzer
    # Exploitation and cracking
    #john                                 # John the Ripper password cracker
    hashcat                               # Password hash cracker
    jwt-cli                               # JWT utility
    metasploit                            # Exploitation framework
    thc-hydra                             # Password brute force
    # Security wordlists and helpers
    seclists                              # Security wordlists

  ];

  # ================================================================================================
  # FONTS
  # ================================================================================================
  fonts.packages = with pkgs; [
    nerd-fonts._0xproto                   # Nerd Font: 0xProto
    nerd-fonts.jetbrains-mono             # Nerd Font: JetBrains Mono
    nerd-fonts.meslo-lg.                  # Nerd Font: MesloLG - Based off apple Menlo
    cantarell-fonts                       # GNOME/GTK default font
  ];

  nixpkgs.overlays = [
    (final: prev: { qutebrowser = prev.qutebrowser.override { enableWideVine = true; }; })
  ];

}

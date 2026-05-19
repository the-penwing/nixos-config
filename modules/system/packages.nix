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

    # ── Creative ──────────────────────────────────────────────────────────────────────────────────
    aseprite                              # Pixel art editor
    feh                                   # Minimal image viewer / wallpaper setter
    imagemagick                           # Image manipulation
    oculante                              # Fast image viewer

    # ── Audio & Video ─────────────────────────────────────────────────────────────────────────────
    ffmpeg                                # Audio Tools
    sunshine                              # Screen Mirroring Host for Moonlight
    vlc                                   # Media player

    # ── Productivity & Office ─────────────────────────────────────────────────────────────────────
    bitwarden-desktop                     # Password manager
    libreoffice-fresh                     # Microsoft Office Equivilant
    obsidian                              # Notes app
    qutebrowser                           # Keyboard-driven browser
    zathura                               # PDF Viewer
    zathuraPkgs.zathura_pdf_poppler       # PDF Extention

    # ── Diagramming & Visualisation ───────────────────────────────────────────────────────────────
    drawio                                # Diagramming tool (for ideas, flowcharts, etc)
    gephi                                 # Another graph visualisation tool
    graphviz                              # Graph visualisation tools
    mermaid-cli                           # CLI tool for generating diagrams from Mermaid syntax
    yed                                   # Graph Visualiser

    # ── Communication & Social ────────────────────────────────────────────────────────────────────
    discord                               # Do I really need to explain this one

    # ── AI & Misc Utilities ───────────────────────────────────────────────────────────────────────
    github-copilot-cli                    # GitHub Cloud AI
    copilot-language-server               # GitHub copilot language server

    # ── Terminal & Editor ─────────────────────────────────────────────────────────────────────────
    ghostty                               # Terminal emulator
    neovim                                # Primary editor
    starship                              # Shell prompt
    tmux                                  # Terminal multiplexer
    vim                                   # Fallback terminal editor

    # ── File Managers ─────────────────────────────────────────────────────────────────────────────
    thunar                                # Lightweight GTK file manager

    # ── Dev Tools ─────────────────────────────────────────────────────────────────────────────────
    arduino-cli                           # Arduino from the command line
    arduino-ide                           # Open-source electronics prototyping platform
    filezilla                             # GUI FTP client
    git                                   # Version control (essential)
    gucharmap                             # Character map useful for designing UIs
    lftp                                  # CLI FTP client
    samba                                 # SMB Client
    smbclient-ng                          # Better SMB client
    sqlitebrowser                         # SQLite GUI

    # ── Programming Languages & Toolchains ────────────────────────────────────────────────────────
    lua54Packages.lua                     # Lua programming / scripting language
    lua-language-server                   # LSP for Lua
    lua54Packages.luacheck                # Linter for Lua
    stylua                                # Code formatter for Lua
    rust-analyzer                         # LSP for editor support
    rustup                                # Rust toolchain manager

    # ── CLI Utilities ─────────────────────────────────────────────────────────────────────────────
    bat                                   # Better cat with syntax highlighting
    bottom                                # A process/system monitor for neovim
    btop                                  # System monitor (also aliased as ps)
    cloc                                  # Count Lines Of Code
    cmatrix                               # Small Command for when I wanna feel like a hacker
    curl                                  # HTTP client
    duf                                   # Better df / disk usage overview
    dust                                  # Better du / directory size analyser
    eza                                   # Better ls with icons/colours
    fastfetch                             # Fast system info
    fd                                    # Fast find replacement
    file                                  # Detect file types
    fzf                                   # Fuzzy finder
    gdu                                   # Disk usage analyzer with console interface
    glow                                  # Render markdown on the cli with pizazzz
    jq                                    # JSON processor
    ripgrep                               # Fast grep replacement
    tldr                                  # Command cheatsheets
    tree                                  # Directory tree viewer
    unzip                                 # Archive extraction
    wget                                  # File downloader
    zip                                   # Archive creation

    # ── Screenshot (Hyprland / Wayland) ───────────────────────────────────────────────────────────
    grim                                  # Screenshot tool
    slurp                                 # Interactive region selector
    swappy                                # Screenshot annotation/editor

    # ── Wayland Clipboard ─────────────────────────────────────────────────────────────────────────
    cliphist                              # Clipboard history daemon
    wl-clipboard                          # Clipboard read/write

    # ── Hyprland Ecosystem ────────────────────────────────────────────────────────────────────────
    bibata-cursors                        # Cursor theme
    hyprpolkitagent                       # Polkit authentication dialogs
    nwg-displays                          # Display configuration GUI
    nwg-look                              # GTK theme manager
    playerctl                             # MPRIS media control
    power-profiles-daemon
    upower
    wlr-randr                             # Wayland output management

    # ── Qt Theming ────────────────────────────────────────────────────────────────────────────────
    dracula-qt5-theme                     # Dracula theme for Qt
    qt6Packages.qt6ct                     # Qt theme configuration tool
    qt6Packages.qtstyleplugin-kvantum     # Kvantum style engine

    # ── Brightness & Audio Controls ───────────────────────────────────────────────────────────────
    brightnessctl                         # Backlight control
    pamixer                               # PulseAudio CLI mixer
    pavucontrol                           # PulseAudio GUI mixer

    # ── GTK / Icon Themes (Dracula) ───────────────────────────────────────────────────────────────
    dracula-icon-theme                    # Icon pack
    dracula-theme                         # GTK theme

    # ── Polkit Agent ──────────────────────────────────────────────────────────────────────────────
    polkit_gnome                          # Auth agent for Hyprland

    # ── System / Misc ─────────────────────────────────────────────────────────────────────────────
    bamf                                  # Window matcher (for docks)
    blueman                               # Bluetooth manager
    ifuse                                 # Mount iOS filesystems
    libfprint                             # fingerprint reader libary
    libheif                               # HEIF/HEIC image codec
    libimobiledevice                      # iOS device support
    usbutils                              # Provides lsusb to check for fingerprint reader
    xdg-utils                             # XDG desktop integration helpers

    # ── Security / Ethical Hacking Lab ────────────────────────────────────────────────────────────
    # Core networking + isolated lab infra
    cacert
    inetutils
    netcat
    openvpn
    openssl
    proxychains-ng
    rlwrap
    virt-manager
    # Recon, scanning, and enumeration
    ffuf
    feroxbuster
    gobuster
    nmap
    rustscan
    whatweb
    # Web application testing
    burpsuite
    sqlmap
    wpscan
    # Active Directory / internal network ops
    bloodhound-py
    enum4linux-ng
    python312Packages.impacket
    smbmap
    # Tunneling and traffic analysis
    chisel
    tcpdump
    wireshark
    # Exploitation and cracking
    hashcat
    jwt-cli
    metasploit
    thc-hydra
    # Security wordlists and helpers
    seclists

  ];

  # ============================================================
  # FONTS
  # ============================================================
  fonts.packages = with pkgs; [
    nerd-fonts._0xproto
    nerd-fonts.jetbrains-mono
    cantarell-fonts                       # GTK default font
  ];

  nixpkgs.overlays = [
    (final: prev: { qutebrowser = prev.qutebrowser.override { enableWideVine = true; }; })
  ];

}

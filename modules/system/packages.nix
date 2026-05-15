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
    aseprite        # Pixel art editor
    oculante        # Fast image viewer
    feh             # Minimal image viewer / wallpaper setter

    # ── Audio & Video ──────────────────────────────────────────
    vlc             # Media player
    ffmpeg          # Audio Tools
    sunshine        # Screen Mirroring Host for Moonlight  
    
    # ── Productivity & Office ──────────────────────────────────
    qutebrowser     # Keyboard-driven browser 
    obsidian        # Note-taking (essential)
    libreoffice-fresh # Microsoft Office Equivilant
    bitwarden-desktop # Password manager (security backup)
    zathura         # PDF Viewer and Extention
    zathuraPkgs.zathura_pdf_poppler

    # ── Communication & Social ─────────────────────────────────
    discord

    # ── AI & Misc Utilities ────────────────────────────────────
    github-copilot-cli # GitHub Cloud AI
    copilot-language-server # GitHub copilot language server

    # ── Terminal & Editor ──────────────────────────────────────
    ghostty         # Terminal emulator
    neovim          # Primary editor
    micro           # Fallback terminal editor
    vim             # Fallback terminal editor for fancier quick edits
    arduino-ide     # Open-source electronics prototyping platform
    arduino-cli     # Arduino from the command line
    drawio          # Diagramming tool (for ideas, flowcharts, etc)
    mermaid-cli     # CLI tool for generating diagrams from Mermaid syntax

    # ── File Managers ──────────────────────────────────────────
    thunar          # Lightweight GTK file manager

    # ── Dev Tools ──────────────────────────────────────────────
    git             # Version control (essential)
    sqlitebrowser   # SQLite GUI (handy when needed)
    starship        # Shell prompt
    gucharmap       # Character map useful for designing UIs
    filezilla       # GUI FTP client
    lftp            # CLI FTP client
    samba           # SMB Client
    smbclient-ng
    rustup          # Rust toolchain manager
    rust-analyzer  # LSP for editor support

    # ── Security / Ethical Hacking Lab ───────────────────────────
    # Core networking + isolated lab infra
    netcat              # Quick TCP/UDP listener and client for testing shells/services
    openvpn             # VPN client for lab platforms (HTB, THM, VPN-based engagements)
    inetutils           # Classic network diagnostics tools
    virt-manager        # Local VM lab management (includes virt-install)
    proxychains-ng      # Route tooling through SOCKS proxies/pivots
    rlwrap              # Better shell usability (history/editing) for basic TTYs

    # Recon, scanning, and enumeration
    nmap                # Network discovery and service/version enumeration
    rustscan            # Fast port discovery front-end for nmap
    masscan             # High-speed TCP port scanner
    amass               # Attack surface mapping and subdomain enumeration
    subfinder           # Passive subdomain enumeration
    dnsrecon            # DNS record and zone transfer recon
    nuclei              # Template-based vulnerability scanner
    feroxbuster         # Recursive content discovery
    gobuster            # Directory, DNS, and vhost brute forcing
    ffuf                # Fast web fuzzing
    whatweb             # Web tech stack fingerprinting
    theharvester        # OSINT email/domain/host collection

    # Web application testing
    burpsuite           # Intercepting proxy for manual web app testing
    sqlmap              # Automated SQL injection testing/exploitation
    nikto               # Web server checks for dangerous defaults and known issues
    wpscan              # WordPress-focused scanner
    wfuzz               # Flexible parameter/content web fuzzer

    # Active Directory / internal network ops
    bloodhound-py       # BloodHound ingestor for AD relationship mapping
    certipy             # AD CS enumeration and abuse testing
    responder           # LLMNR/NBT-NS/MDNS poisoning in controlled assessments
    smbmap              # SMB share and permission enumeration
    enum4linux-ng       # SMB/NetBIOS enumeration helper
    nbtscan             # NetBIOS name enumeration
    onesixtyone         # Fast SNMP community string scanner
    snmpcheck           # SNMP host enumeration
    netexec             # Successor to crackmapexec for AD/SMB/WinRM workflows
    python312Packages.impacket # Protocol tooling for SMB/RPC/Kerberos/NTLM operations
    evil-winrm          # WinRM shell for Windows administration testing
    chisel              # TCP/UDP tunneling for pivoting in segmented labs

    # Wireless and traffic analysis
    aircrack-ng         # 802.11 auditing suite
    hcxdumptool         # PMKID/handshake capture tool
    hcxtools            # Handshake/PMKID conversion utilities
    wireshark           # Packet capture and protocol analysis GUI
    tcpdump             # CLI packet capture and filtering
    bettercap           # Network MITM and L2/L3 attack framework (lab use)
    mitmproxy           # HTTP(S) intercepting proxy for API/web testing

    # Exploitation, cracking, and reverse engineering
    metasploit          # Exploit framework and payload tooling
    exploitdb           # Searchsploit and local exploit reference database
    john                # Offline password hash cracking
    hashcat             # GPU-accelerated password recovery
    thc-hydra           # Online password brute-force tester
    jwt-cli             # Decode and inspect JWTs
    yara                # Rule-based binary/file matching engine
    volatility3         # Memory forensics framework
    ghidra              # Reverse engineering suite
    binwalk             # Firmware/binary carving and extraction
    radare2             # CLI reverse engineering/disassembly toolkit

    # Security wordlists and helpers
    seclists            # Curated pentest wordlists
    assetfinder         # Additional passive subdomain discovery

    # ── CLI Utilities ──────────────────────────────────────────
    wget            # File downloader
    curl            # HTTP client
    unzip           # Archive extraction
    zip             # Archive creation
    fzf             # Fuzzy finder
    fd              # Fast find replacement
    btop            # System monitor (also aliased as ps)
    fastfetch       # Fast system info
    cmatrix         # Small Command for when I wanna feel like a hacker
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
    glow            # Render markdown on the cli with pizazzz
    graphviz
    libfprint
    usbutils        # Provides lsusb to check for fingerprint reader
    cloc            # Count Lines Of Code
    file            # Detect file types
    gdu             # Disk usage analyzer with console interface
    bottom          # A customizable cross-platform graphical process/system monitor for the terminal.

    # ── Screenshot (Hyprland / Wayland) ────────────────────────
    grim            # Screenshot tool
    slurp           # Interactive region selector
    swappy          # Screenshot annotation/editor

    # ── Wayland Clipboard ──────────────────────────────────────
    wl-clipboard    # Clipboard read/write
    cliphist        # Clipboard history daemon

    # ── Hyprland Ecosystem ─────────────────────────────────────
    upower
    power-profiles-daemon
    hyprpolkitagent # Polkit authentication dialogs
    nwg-displays    # Display configuration GUI
    wlr-randr       # Wayland output management
    nwg-look        # GTK theme manager
    playerctl       # MPRIS media control
    bibata-cursors  # Cursor theme

    # ── Qt Theming ─────────────────────────────────────────────
    qt6Packages.qt6ct                  # Qt theme configuration tool
    qt6Packages.qtstyleplugin-kvantum  # Kvantum style engine
    dracula-qt5-theme

    # ── Brightness & Audio Controls ────────────────────────────
    brightnessctl   # Backlight control
    pamixer         # PulseAudio CLI mixer
    pavucontrol     # PulseAudio GUI mixer

    # ── GTK / Icon Themes (Dracula) ────────────────────────────
    dracula-theme      # GTK theme
    dracula-icon-theme # Icon pack

    # ── Polkit Agent ───────────────────────────────────────────
    polkit_gnome    # Auth agent for Hyprland

    # ── System / Misc ──────────────────────────────────────────
    bamf            # Window matcher (for docks)
    blueman         # Bluetooth manager
    libheif         # HEIF/HEIC image codec
    xdg-utils       # XDG desktop integration helpers
    libimobiledevice # iOS device support
    ifuse           # Mount iOS filesystems

  ];

  # ============================================================
  # FONTS
  # ============================================================
  fonts.packages = with pkgs; [
    nerd-fonts._0xproto
    nerd-fonts.jetbrains-mono
    nerd-fonts.envy-code-r
    cantarell-fonts           # GTK default font
  ];

  nixpkgs.overlays = [
    (final: prev: { qutebrowser = prev.qutebrowser.override { enableWideVine = true; }; })
  ];

}

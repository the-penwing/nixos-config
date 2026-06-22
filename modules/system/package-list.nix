# Package catalogue for nixos-p14s.
#
# Purpose:
# - Keep package declarations in one place
# - Provide default application metadata used by MIME defaults
# - Make category-based cleanup easier over time
{ pkgs, lib }:
let
  categories = {
    # ========================================================================
    # Core System Utilities
    # Fundamental tooling for files, networks, encryption, and basic operations
    # ========================================================================
    core = with pkgs; [
      # Compression & Archiving
      unzip
      zip

      # Environment, Shell & Prompts
      direnv
      starship

      # Networking & Data Transfer
      curl
      wget

      # Security, Keys & Certificates
      cacert
      gnupg
      openssl

      # System Information & Documentation
      file
      man-pages
      man-pages-posix
      pass
      rsync
      tree
      xdg-utils

      # Text and File Search + Structural Transformation
      fd
      fzf
      jq
      ripgrep
      sd

      # Version Control Systems
      git
      lazygit
    ];

    # ========================================================================
    # Terminal-Based User Interfaces (TUI) & CLI
    # Interactive command-line monitors, file managers, and text viewers
    # ========================================================================
    cli = with pkgs; [
      # Analysis & Metrics
      cloc

      # Interactive File & Navigation Managers
      eza
      yazi
      zoxide

      # System Health, Disk & Resource Monitors
      btop
      duf
      dust
      fastfetch
      gdu

      # Text Rendering & Document Inspection
      bat
      glow
      tldr
    ];

    # ========================================================================
    # Development Stack
    # Languages, specialized LSPs, compilation chains, and editors
    # ========================================================================
    dev = with pkgs; [
      # Artificial Intelligence & Prototyping
      copilot-language-server
      github-copilot-cli

      # Assembly & Low-Level Processing
      asm-lsp
      binutils
      nasm

      # C/C++ Ecosystem & Tooling
      clang
      clang-tools
      gcc
      gnumake
      libclang
      pkg-config
      xxd

      # Diagramming & Technical Graphics
      graphviz
      mermaid-cli

      # Editors & Multiplexers
      ghostty
      neovim
      tmux
      vim
      zellij

      # Remote File Management
      filezilla

      # Lua Language Runtime & Formatting
      lua-language-server
      lua55Packages.lua
      lua55Packages.luacheck
      lua55Packages.luarocks
      selene
      stylua

      # Python Runtime & Code Standards
      black
      pyenv
      python3
      uv

      # Structural Formats & Databases
      sqlite
      sqlitebrowser

      # Target Compilation & Execution
      act
      cargo-zigbuild
      cdrkit
      nixd
      nsis
      nodejs
      osslsigncode
      zig
    ];

    # ========================================================================
    # Graphical User Interface (GUI) Applications
    # Heavyweight standalone client programs, web tools, and asset managers
    # ========================================================================
    gui = with pkgs; [
      # Communications & Messaging
      discord

      # Digital Art & Image Compositing
      aseprite
      drawio
      imagemagick

      # Host File System Shells
      kdePackages.dolphin
      kdePackages.dolphin-plugins

      # Media Playback & Visual Rendering
      feh
      oculante
      vlc

      # Office Productivity & Knowledge Bases
      libreoffice-fresh
      obsidian
      zathura
      zathuraPkgs.zathura_pdf_poppler

      # Password Storage
      bitwarden-desktop

      # Web Navigation
      qutebrowser

    ];

    # ========================================================================
    # Desktop Environment & Hardware Controls
    # Wayland protocols, styling assets, volume mixers, and window hooks
    # ========================================================================
    desktop = with pkgs; [
      # Application Orchestration & Launchers
      fuzzel
      kando

      # Audio Backends, Sinks & Mixers
      pamixer
      pavucontrol
      playerctl

      # Hardware Integration & Radios
      blueman

      # Layout Capture & Display Managers
      grim
      slurp
      swappy
      wlr-randr

      # Policy Agents & Privilege Scalers
      hyprpolkitagent
      polkit_gnome

      # Power Topologies & Backlights
      brightnessctl
      ddcutil
      power-profiles-daemon
      upower

      # System Theming, Icons & Engine Rules
      bibata-cursors
      dracula-icon-theme
      dracula-qt5-theme
      dracula-theme
      nwg-look
      qt6Packages.qt6ct
      qt6Packages.qtstyleplugin-kvantum

      # Clipboard Intermediaries
      cliphist
      wl-clipboard
    ];

    # ========================================================================
    # Penetration Testing & Networking
    # Security auditing stacks, fuzzer arrays, and protocol scrapers
    # ========================================================================
    security = with pkgs; [
      # Host Exploration & Network Mapping
      chisel
      inetutils
      netcat
      nmap
      openvpn
      rustscan
      tcpdump
      wireshark

      # Inter-process Transport & Protocol Exploits
      samba
      smbclient-ng
      smbmap

      # Payload Deployment & Exploitation
      metasploit
      sqlmap

      # Signatures & Local Cryptanalysis
      hashcat
      john

      # Web Scanning & Endpoint Fuzzing
      ffuf
      gobuster

      # Wireless Layer Auditing
      aircrack-ng
      hcxtools
      iw
    ];

    # ========================================================================
    # System Infrastructure & Media Backends
    # Low-level system interfaces, archive layers, and media codecs
    # ========================================================================
    system-infra = with pkgs; [
      # Archive Handling & Unpacking
      p7zip
      unar

      # Hardware Diagnostics & Speed Benches
      speedtest-cli
      usbutils

      # iOS System Subsystem Interoperability
      ifuse
      libimobiledevice

      # Network Pipelines & Sync Bridges
      lftp
      rclone

      # Processing Pipemaps & AV Codecs
      ffmpeg
      ffmpegthumbnailer
      libheif
      mediainfo
      poppler-utils

      # Terminal Screensavers & Overlays
      cmatrix

      # Video Frame Streaming Host
      sunshine

      # Vector Schematics
      yed

      # Window Matchers
      bamf
      gucharmap
    ];
  };
in
rec {
  inherit categories;

  systemPackages = lib.unique (lib.flatten (builtins.attrValues categories));

  fonts = with pkgs; [
    cantarell-fonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
  ];

  defaults = {
    browserDesktop = "org.qutebrowser.qutebrowser.desktop";
    terminalDesktop = "com.mitchellh.ghostty.desktop";
    fileManagerDesktop = "org.kde.dolphin.desktop";
    editorDesktop = "nvim.desktop";
    pdfDesktop = "org.pwmt.zathura.desktop";
  };

  mimeDefaults = {
    "application/pdf" = defaults.pdfDesktop;
    "inode/directory" = defaults.fileManagerDesktop;
    "text/html" = defaults.browserDesktop;
    "x-scheme-handler/about" = defaults.browserDesktop;
    "x-scheme-handler/http" = defaults.browserDesktop;
    "x-scheme-handler/https" = defaults.browserDesktop;
    "x-scheme-handler/unknown" = defaults.browserDesktop;
  };
}

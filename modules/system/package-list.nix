# Package catalogue for nixos-p14s.
#
# Purpose:
# - Keep package declarations in one place
# - Provide default application metadata used by MIME defaults
# - Make category-based cleanup easier over time
{
  pkgs,
  lib,
}: let
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
      gnupg-pkcs11-scd
      pass
      openssl
      opensc

      # Docs
      man-pages
      man-pages-posix
      tldr

      # Text and File Search + Structural Transformation
      fd
      fzf
      jq
      ripgrep
      sd

      # Version Control Systems
      git
      lazygit
      rsync
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
      file
      tree
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
    ];

    # ========================================================================
    # Development Stack
    # Languages, specialized LSPs, compilation chains, and editors
    # ========================================================================
    dev = with pkgs; [
      # AI & Prototyping
      copilot-language-server
      github-copilot-cli
      github-cli

      # Assembly & Low-Level
      asm-lsp
      binutils
      nasm

      # C Ecosystem
      clang
      clang-tools
      gcc
      gnumake
      glibc
      libclang
      pkg-config
      xxd

      # Languages & Runtimes
      lua55Packages.lua
      lua55Packages.luarocks
      nodejs
      python3
      pyenv
      zig

      # Language Servers (LSP)
      bash-language-server
      vscode-langservers-extracted
      lua-language-server
      lua55Packages.luacheck
      pyright
      tailwindcss-language-server
      taplo
      typescript-language-server
      yaml-language-server
      zls

      # Formatters & Linters
      markdownlint-cli2
      marksman
      black
      eslint_d
      prettier
      selene
      shellcheck
      shfmt
      stylua

      # Editors & Multiplexers
      ghostty
      neovim
      sesh
      tmux
      vim
      zellij

      # Build & Compilation
      act
      cargo-zigbuild
      cdrkit
      gnumake
      cmake
      nsis
      osslsigncode
      rcodesign

      # Nix Tooling
      nil
      nixd
      nix-search-tv

      # Data & Databases
      sqlite
      sqlitebrowser

      # Diagramming & Graphics
      drawio
      graphviz
      mermaid-cli

      # Python Tools
      uv

      # UI & Resources
      gucharmap

      # File Management
      filezilla

      # RP2350
      pico-sdk
      picotool
      gcc-arm-embedded
      probe-rs-tools
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
      imagemagick

      # Host File System Shells
      kdePackages.dolphin
      kdePackages.dolphin-plugins

      # Media Playback & Visual Rendering
      feh
      vlc

      # Office Productivity & Knowledge Bases
      libreoffice-fresh
      obsidian
      zathura
      zathuraPkgs.zathura_pdf_poppler

      # Password Storage
      bitwarden-desktop

      # Web Browser
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
      xdg-utils

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
      libusb1

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

      # Window Matchers
      bamf
    ];
  };
in rec {
  inherit categories;

  systemPackages = lib.unique (lib.flatten (builtins.attrValues categories));

  fonts = with pkgs; [
    nerd-fonts.meslo-lg
  ];

  defaults = {
    browserDesktop = "firefox.desktop";
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

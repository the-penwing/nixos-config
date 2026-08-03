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
      cloudflared

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
      zeal

      # Text and File Search + Structural Transformation
      fd
      fzf
      jq
      ripgrep
      sd

      # Version Control Systems
      git
      github-cli
      tea
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
      # ---  Core Editors, Terminals & Multiplexers ---
      neovim
      helix
      ghostty
      tmux
      sesh
      tree-sitter

      # --- Low-Level, C & Zig Ecosystems ---
      binary # Convert Numbers Between Bases
      # Assembly
      nasm
      asm-lsp
      nasmfmt
      binutils
      # C / C++
      gcc
      glibc
      clang
      libclang
      lldb
      clang-tools
      cmake
      gnumake
      pkg-config
      xxd
      # Zig
      zig
      zls

      # --- Managed Languages & Runtimes ---
      # Python
      python3
      pyenv
      uv
      pyright
      ruff
      black
      # Lua
      lua55Packages.lua
      lua55Packages.luarocks
      lua55Packages.luacheck
      lua-language-server
      selene
      stylua
      # Kotlin
      ktlint
      detekt
      kotlin-language-server
      # Shell
      bash-language-server
      shellcheck
      shfmt

      # --- Web & Frontend Stack ---
      browser-sync
      nodejs
      pnpm
      typescript-language-server
      vscode-langservers-extracted
      tailwindcss-language-server
      eslint_d

      # --- Nix Infrastructure & Tooling ---
      nixd
      nil
      alejandra
      nix-search-tv

      # --- Data, Serialization & Documentation ---
      # Databases & Formats
      sqlite
      sqlitebrowser
      taplo # TOML
      yaml-language-server
      yamllint
      yamlfmt
      # Markdown & Formatting
      marksman
      markdownlint-cli2
      prettier

      # --- Build, Automation & CI/CD ---
      act # Local GitHub Actions
      cargo-zigbuild
      docker-compose

      # --- Code Signing & Deployment Packaging ---
      rcodesign
      osslsigncode
      nsis # Windows Installer
      cdrkit # ISO/CD-ROM imaging
      filezilla # File Transfer

      # --- Hardware & Embedded Development (RP2350 / ARM) ---
      gcc-arm-embedded
      pico-sdk
      picotool
      probe-rs-tools

      # --- AI, Diagrams & Utilities ---
      # AI Assistance
      github-copilot-cli
      copilot-language-server
      llama-cpp-vulkan
      # Visuals & Graphics
      drawio
      graphviz
      gnome-graphs
      mermaid-cli
      gucharmap # Unicode character map
    ];
    # ========================================================================
    # Graphical User Interface (GUI) Applications
    # Heavyweight standalone client programs, web tools, and asset managers
    # ========================================================================
    gui = with pkgs; [
      # Communications & Messaging
      iamb
      discord

      # Digital Art & Image Compositing
      aseprite
      imagemagick
      gimp
      krita
      xournalpp
      rnote

      # Host File System Shells
      nautilus
      kdePackages.dolphin
      kdePackages.dolphin-plugins

      # Media Playback & Visual Rendering
      feh
      vlc

      # Games
      solitaire-tui

      # Office Productivity & Knowledge Bases
      libreoffice-fresh
      obsidian
      zathura
      zathuraPkgs.zathura_pdf_poppler

      # Password Storage
      bitwarden-desktop

      # Web Browser
      qutebrowser
      chromium # Only for Bluetooth Cubing
    ];

    # ========================================================================
    # Desktop Environment & Hardware Controls
    # Wayland protocols, styling assets, volume mixers, and window hooks
    # ========================================================================
    desktop = with pkgs; [
      # Application Orchestration & Launchers
      bemoji
      fuzzel
      kando
      waybar
      rofi

      # Audio Backends, Sinks & Mixers
      pamixer
      pavucontrol
      playerctl
      portaudio

      # Hardware Integration & Radios
      blueman

      # Layout Capture & Display Managers
      swaynotificationcenter
      libnotify
      hyprlock
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
      upower

      # System Theming, Icons & Engine Rules
      hyprpaper
      bibata-cursors
      dracula-icon-theme
      papirus-icon-theme
      dracula-qt5-theme
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
      exfatprogs

      # iOS System Subsystem Interoperability
      ifuse
      libimobiledevice

      # Network Pipelines & Sync Bridges
      lftp
      sshfs
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
    fileManagerDesktop = "org.gnome.Nautilus.desktop";
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

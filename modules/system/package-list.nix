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
      # --- Shell Environment & Navigation ---
      direnv
      starship
      zoxide

      # --- Search & Text Processing ---
      bat
      fd
      fzf
      glow
      jq
      ripgrep
      sd

      # --- Networking & Data Transfer ---
      cloudflared
      curl
      rsync
      wget

      # --- Compression & Archiving ---
      p7zip
      unar
      unzip
      zip

      # --- Security, Keys & Certificates ---
      cacert
      gnupg
      gnupg-pkcs11-scd
      opensc
      openssl
      openssl.dev
      pass

      # --- Documentation & Manuals ---
      man-pages
      man-pages-posix
      tldr
      zeal

      # --- Version Control Systems ---
      git
      github-cli
      lazygit
      tea
    ];

    # ========================================================================
    # Terminal-Based User Interfaces (TUI) & CLI
    # Interactive command-line monitors, file managers, and text viewers
    # ========================================================================
    cli = with pkgs; [
      # --- System Health, Disk & Resource Monitors ---
      btop
      cloc
      duf
      dust
      fastfetch
      gdu

      # --- Interactive File & Navigation Managers ---
      eza
      file
      tree
      yazi

      # --- Terminal Toys & Visuals ---
      cmatrix
    ];

    # ========================================================================
    # Development Stack
    # Languages, specialized LSPs, compilation chains, and editors
    # ========================================================================
    dev = with pkgs; [
      # --- Core Editors, Terminals & Multiplexers ---
      ghostty
      helix
      neovim
      sesh
      tmux
      tree-sitter

      # --- Assembly & Low-Level ---
      asm-lsp
      binary
      binutils
      nasm
      nasmfmt
      xxd

      # --- C & C++ Stack ---
      clang
      clang-tools
      cmake
      gcc
      glib
      glib-networking
      glibc
      gnumake
      libclang
      lld
      lldb
      mold
      pkg-config
      sccache

      # --- Rust Stack ---
      cargo-edit
      cargo-expand
      cargo-watch
      cargo-zigbuild

      # --- Zig Stack ---
      zig
      zls

      # --- Python Stack ---
      black
      pyenv
      pyright
      python3
      python3Packages.debugpy
      ruff
      uv

      # --- Lua Stack ---
      lua-language-server
      lua55Packages.lua
      lua55Packages.luacheck
      lua55Packages.luarocks
      selene
      stylua

      # --- Web, Node & TypeScript Stack ---
      browser-sync
      eslint_d
      nodejs
      pnpm
      slint-lsp
      tailwindcss-language-server
      typescript-language-server
      vscode-langservers-extracted

      # --- Kotlin & JVM Stack ---
      detekt
      kotlin-language-server
      ktlint

      # --- Shell Scripting ---
      bash-language-server
      shellcheck
      shfmt

      # --- Hardware & Embedded Development (ARM / RP2350) ---
      android-tools
      gcc-arm-embedded
      pico-sdk
      picocom
      picotool
      probe-rs-tools
      tio

      # --- Nix Infrastructure & Tooling ---
      alejandra
      nil
      nix-search-tv
      nixd

      # --- Data, Formats & Documentation ---
      markdownlint-cli2
      marksman
      prettier
      sqlite
      sqlitebrowser
      taplo
      yaml-language-server
      yamlfmt
      yamllint

      # --- Build, Packaging & Deployment ---
      act
      cdrkit
      docker-compose
      filezilla
      ldid-procursus
      nsis
      osslsigncode
      rcodesign

      # --- AI Assistance & Diagramming ---
      copilot-language-server
      drawio
      github-copilot-cli
      gnome-graphs
      graphviz
      gucharmap
      llama-cpp-vulkan
      mermaid-cli

      # --- Development UI Libraries ---
      at-spi2-atk
      atkmm
      cairo
      fontconfig
      fontconfig.dev
      gdk-pixbuf
      gtk3
      librsvg
      libsoup_3
      webkitgtk_4_1
      xdotool
    ];

    # ========================================================================
    # Desktop Environment & Hardware Controls
    # Wayland protocols, styling assets, volume mixers, and window hooks
    # ========================================================================
    desktop = with pkgs; [
      # --- Launchers & UI Overlays ---
      bemoji
      fuzzel
      kando
      libnotify
      rofi
      swaynotificationcenter
      waybar

      # --- Display Capture & Layout ---
      grim
      hyprlock
      slurp
      swappy
      wlr-randr

      # --- Audio Backends & Control ---
      pamixer
      pavucontrol
      playerctl
      portaudio

      # --- Hardware, Power & Radios ---
      blueman
      brightnessctl
      ddcutil
      upower

      # --- Polkit, Policy Agents & Clipboard ---
      cliphist
      hyprpolkitagent
      polkit_gnome
      wl-clipboard
      xdg-utils

      # --- System Theming, Icons & Engines ---
      bibata-cursors
      dracula-icon-theme
      dracula-qt5-theme
      hyprpaper
      nwg-look
      papirus-icon-theme
      qt6Packages.qt6ct
      qt6Packages.qtstyleplugin-kvantum
    ];

    # ========================================================================
    # Graphical User Interface (GUI) Applications
    # Heavyweight standalone client programs, web tools, and asset managers
    # ========================================================================
    gui = with pkgs; [
      # --- Web Browsers & Communications ---
      bitwarden-desktop
      chromium
      discord
      iamb
      qutebrowser

      # --- Media, Art & CAD ---
      aseprite
      feh
      gimp
      imagemagick
      kicad-unstable
      krita
      rnote
      vlc
      xournalpp

      # --- Office Productivity & Knowledge Bases ---
      libreoffice-fresh
      obsidian
      zathura
      zathuraPkgs.zathura_pdf_poppler

      # --- File System Shells & Managers ---
      kdePackages.dolphin
      kdePackages.dolphin-plugins
      nautilus

      # --- Games ---
      solitaire-tui
    ];

    # ========================================================================
    # Penetration Testing & Security Auditing
    # Security auditing stacks, fuzzer arrays, and protocol scrapers
    # ========================================================================
    security = with pkgs; [
      # --- Reconnaissance & Mapping ---
      chisel
      inetutils
      netcat
      nmap
      openvpn
      rustscan
      tcpdump
      wireshark

      # --- Exploitation & Transport Protocols ---
      metasploit
      samba
      smbclient-ng
      smbmap
      sqlmap

      # --- Web Scanning & Endpoint Fuzzing ---
      ffuf
      gobuster

      # --- Cryptanalysis & Password Cracking ---
      hashcat
      john

      # --- Wireless Auditing ---
      aircrack-ng
      hcxtools
      iw
    ];

    # ========================================================================
    # System Infrastructure & Media Backends
    # Low-level system interfaces, archive layers, and media codecs
    # ========================================================================
    system-infra = with pkgs; [
      # --- Diagnostics, Drives & Hardware ---
      exfatprogs
      libusb1
      speedtest-cli
      udiskie
      usbutils

      # --- iOS System Subsystem Interoperability ---
      ifuse
      libimobiledevice
      usbmuxd

      # --- Network Pipelines & Sync Bridges ---
      lftp
      rclone
      sshfs

      # --- Processing Pipelines & AV Codecs ---
      ffmpeg
      ffmpegthumbnailer
      libheif
      mediainfo
      poppler-utils

      # --- Streaming & Window Matchers ---
      bamf
      sunshine
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

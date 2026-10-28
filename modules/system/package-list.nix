# modules/system/package-list.nix
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
      # --- Search & Text Processing ---
      bat
      fd
      glow
      jq
      ripgrep
      sd

      # --- Networking & Data Transfer ---
      dig
      impala
      gping
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
      tlrc

      # --- Version Control Systems ---
      git
      github-cli
      lazygit
      tea
      delta
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

      # --- Interactive File & Navigation Managers ---
      eza
      file
      tree

      # --- Terminal Toys & Visuals ---
      cmatrix
    ];

    # ========================================================================
    # Development Stack
    # Languages, specialized LSPs, compilation chains, and editors
    # ========================================================================
    dev = with pkgs; [
      # --- Core Editors, Terminals & Multiplexers ---
      neovim
      sesh
      tree-sitter

      # --- Build & Test ---
      just
      hyperfine
      gnumake
      cmake

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
      gcc
      libclang
      lld
      lldb
      mold
      pkg-config
      sccache

      # --- Rust Stack ---
      bacon
      bacon-ls
      cargo-edit
      cargo-expand
      cargo-zigbuild
      slint-lsp
      (rust-bin.stable.latest.default.override {
        extensions = ["rust-src" "rust-analyzer"];
        targets = [
          "x86_64-unknown-linux-gnu"
          "thumbv8m.main-none-eabihf"
          "aarch64-unknown-linux-musl" # Raspberry Pi (Alpine)
        ];
      })

      # --- Go Stack ---
      go
      delve
      golangci-lint

      # --- Zig Stack ---
      zig

      # --- Python Stack ---
      black
      pyenv
      pyright
      python3
      python3Packages.debugpy
      ruff
      uv

      # --- Lua / Teal Stack ---
      lua54Packages.lua
      lua54Packages.tl
      lua54Packages.cyan
      lua54Packages.luacheck
      lua54Packages.luarocks
      selene
      stylua

      # --- Web, Node & TypeScript Stack ---
      nodejs
      pnpm
      prettier
      # Elm Stack
      elmPackages.elm
      elmPackages.elm-format
      elmPackages.elm-test
      elmPackages.elm-live
      elmPackages.elm-review
      elm2nix

      # --- Kotlin & JVM Stack ---
      jetbrains.idea
      jdk17
      gradle_8
      kotlin
      # Android
      android-studio
      android-tools
      scrcpy

      # --- Hardware & Embedded Development (ARM / RP2350) ---
      gcc-arm-embedded
      pico-sdk
      picotool
      probe-rs-tools
      flip-link
      tio

      # --- Nix Infrastructure & Tooling ---
      alejandra
      nil
      nix-search-tv
      nixd

      # --- AI Assistance & Diagramming ---
      github-copilot-cli
      mermaid-cli
    ];

    # ========================================================================
    # Desktop Environment & Hardware Controls
    # Wayland protocols, styling assets, volume mixers, and window hooks
    # ========================================================================
    desktop = with pkgs; [
      # --- Launchers & UI Overlays ---
      bemoji
      libnotify
      swaynotificationcenter
      ashell
      fuzzel

      # --- Display Capture & Layout ---
      grim
      hyprlock
      slurp
      swappy
      wlr-randr
      wl-screenrec

      # --- Audio Backends & Control ---
      pamixer
      pavucontrol
      playerctl

      # --- Hardware, Power & Radios ---
      bluetui
      brightnessctl
      ddcutil
      upower

      # --- Polkit, Policy Agents & Clipboard ---
      cliphist
      hyprpolkitagent
      wl-clipboard
      xdg-utils

      # --- System Theming, Icons & Engines ---
      bibata-cursors
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
      vesktop
      mprisence
      iamb

      # --- Media, Art & CAD ---
      aseprite
      gimp
      feh
      vlc
      xournalpp
      gucharmap

      # --- Office Productivity & Knowledge Bases ---
      libreoffice-stable
      obsidian
      zathura
      zathuraPkgs.zathura_pdf_poppler

      # --- File System Shells & Managers ---
      thunar

      # --- Games ---
      flycast
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
    fileManagerDesktop = "thunar.desktop";
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

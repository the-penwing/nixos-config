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
    # System Utilities
    # Core tools: file, network, compression, utilities
    # ========================================================================
    core = with pkgs; [
      cacert
      curl
      direnv
      fd
      file
      fzf
      git
      gnupg
      jq
      ripgrep
      rsync
      pass
      sd
      starship
      tree
      unzip
      wget
      xdg-utils
      zip
    ];

    # ========================================================================
    # Terminal & CLI Tools
    # Modern CLI utilities: file viewers, system monitors, file managers
    # ========================================================================
    cli = with pkgs; [
      bat
      btop
      cloc
      duf
      dust
      eza
      fastfetch
      gdu
      glow
      tldr
      yazi
      zoxide
    ];

    # ========================================================================
    # Development Tools
    # Compilers, languages, LSPs, build tools, version managers, databases
    # ========================================================================
    dev = with pkgs; [
      filezilla
      gcc
      rustc
      cargo
      rust-analyzer
      gnumake
      graphviz
      ghostty
      copilot-language-server
      github-copilot-cli
      act
      lua-language-server
      lua54Packages.lua
      lua54Packages.luacheck
      lua54Packages.luarocks
      mermaid-cli
      nodejs
      neovim
      pkg-config
      pyenv
      python3
      sqlite
      sqlitebrowser
      stylua
      tea
      tmux
      uv
      vim
      xxd
      zig
      zellij
    ];

    # ========================================================================
    # GUI Applications
    # Desktop applications, media players, office tools
    # ========================================================================
    gui = with pkgs; [
      aseprite
      bitwarden-desktop
      discord
      drawio
      feh
      imagemagick
      kdePackages.dolphin
      kdePackages.dolphin-plugins
      libreoffice-fresh
      obsidian
      oculante
      pavucontrol
      qutebrowser
      vlc
      zathura
      zathuraPkgs.zathura_pdf_poppler
    ];

    # ========================================================================
    # Desktop Environment
    # Themes, cursors, desktop utilities, Wayland/Hyprland tools
    # ========================================================================
    desktop = with pkgs; [
      bibata-cursors
      blueman
      brightnessctl
      cliphist
      dracula-icon-theme
      dracula-qt5-theme
      dracula-theme
      grim
      hyprpolkitagent
      nwg-look
      pamixer
      playerctl
      polkit_gnome
      power-profiles-daemon
      qt6Packages.qt6ct
      qt6Packages.qtstyleplugin-kvantum
      slurp
      swappy
      upower
      wl-clipboard
      wlr-randr
    ];

    # ========================================================================
    # Security & Networking
    # Penetration testing, security tools, network analysis
    # ========================================================================
    security = with pkgs; [
      chisel
      ffuf
      gobuster
      hashcat
      inetutils
      metasploit
      netcat
      nmap
      openvpn
      openssl
      rustscan
      samba
      smbclient-ng
      smbmap
      sqlmap
      tcpdump
      wireshark
    ];

    # ========================================================================
    # Media & Archives
    # Video/audio processing, image tools, archive utilities
    # ========================================================================
    media = with pkgs; [
      ffmpeg
      ffmpegthumbnailer
      libheif
      mediainfo
      poppler-utils
      p7zip
      sunshine
      unar
    ];

    # ========================================================================
    # Miscellaneous
    # Special tools and utilities that don't fit elsewhere
    # ========================================================================
    misc = with pkgs; [
      bamf
      cmatrix
      gucharmap
      ifuse
      libimobiledevice
      lftp
      usbutils
      yed
    ];
  };
in
rec {
  inherit categories;

  systemPackages = lib.unique (lib.flatten (builtins.attrValues categories));

  fonts = with pkgs; [
    cantarell-fonts
    nerd-fonts._0xproto
    nerd-fonts.fira-code
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

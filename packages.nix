# Package catalogue for nixos-t14s.
#
# Purpose:
# - Keep package declarations in one place
# - Provide default application metadata used by MIME defaults
# - Make category-based cleanup easier over time
{ pkgs, lib }:
let
  categories = {
    core = with pkgs; [
      cacert
      curl
      fd
      file
      fzf
      git
      jq
      ripgrep
      rsync
      tree
      unzip
      wget
      xdg-utils
      zip
    ];

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

    dev = with pkgs; [
      filezilla
      gcc
      gnumake
      graphviz
      lua-language-server
      lua54Packages.lua
      lua54Packages.luacheck
      lua54Packages.luarocks
      mermaid-cli
      nodejs
      pkg-config
      pyenv
      python3
      rust-analyzer
      rustup
      sqlite
      sqlitebrowser
      stylua
      tea
      uv
    ];

    gui = with pkgs; [
      aseprite
      bitwarden-desktop
      discord
      drawio
      feh
      ghostty
      imagemagick
      kdePackages.dolphin
      kdePackages.dolphin-plugins
      libreoffice-fresh
      obsidian
      oculante
      pavucontrol
      qutebrowser
      tmux
      vlc
      zathura
      zathuraPkgs.zathura_pdf_poppler
    ];

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

    media = with pkgs; [
      ffmpeg
      ffmpegthumbnailer
      libheif
      mediainfo
      poppler_utils
      p7zip
      sunshine
      unar
    ];

    misc = with pkgs; [
      bamf
      cmatrix
      copilot-language-server
      github-copilot-cli
      gucharmap
      ifuse
      libimobiledevice
      lftp
      neovim
      usbutils
      vim
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

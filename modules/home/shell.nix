# Home shell/developer ergonomics module.
#
# Purpose:
# - Keep per-user shell tooling and environment variables together
# - Manage direnv, starship, and fzf declaratively via home-manager
# - Keep SSH agent behaviour explicit and auditable
{pkgs, ...}: {
  home.packages = with pkgs; [
    pass-git-helper
  ];

  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*" = {
      addKeysToAgent = "yes";
      identitiesOnly = "yes";
      identityFile = "~/.ssh/id_ed25519";
    };
    extraConfig = ''
      Host github.com
        HostName github.com
        User git

      Host gitea.taile9a1d6.ts.net
        HostName gitea.taile9a1d6.ts.net
        User git

      Host alpine
        Hostname 192.168.50.222
        Port 22
        User root
      Host alpine-ts
        Hostname alpine-rpi
        Port 22
        User root

      Host homelab
        Hostname 192.168.50.117
        Port 22
        User benvl
      Host homelab-ts
        Hostname home-server
        Port 22
        User benvl

      Host echo-ts
        Hostname echo
        Port 8022
        user u0_a332
        SetEnv TERM=xterm-256color
    '';
  };

  programs.git = {
    enable = true;
    signing = {
      key = "3949612C4B58A93F3DCD7488A11420689178B907";
      signByDefault = true;
    };
    settings = {
      init.defaultBranch = "main";
      user = {
        name = "Ben van Leeuwen";
        email = "benvanleeuwen01@gmail.com";
      };
      gpg = {
        format = "openpgp";
      };
      credential.helper = "!pass-git-helper $@";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}

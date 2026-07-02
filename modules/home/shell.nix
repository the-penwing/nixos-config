# Home shell/developer ergonomics module.
#
# Purpose:
# - Keep per-user shell tooling and environment variables together
# - Manage direnv, starship, and fzf declaratively via home-manager
# - Keep SSH agent behaviour explicit and auditable
{pkgs, ...}: {
  home.packages = with pkgs; [
    lazygit
    pass-git-helper
  ];

  programs.starship = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
  };

  services.ssh-agent.enable = true;

  # systemd.user.services.load-pkcs11-key = {
  #   Unit = {
  #     Description = "Load PKCS#11 SSH key into ssh-agent";
  #     After = ["ssh-agent.service" "dbus.service"];
  #     Requires = ["ssh-agent.service"];
  #   };
  #   Service = {
  #     Type = "oneshot";
  #     ExecStart = "${pkgs.bash}/bin/bash -c 'sleep 2 && ${pkgs.openssh}/bin/ssh-add -s /run/current-system/sw/lib/opensc-pkcs11.so || true'";
  #     RemainAfterExit = true;
  #   };
  #   Install = {
  #     WantedBy = ["default.target"];
  #   };
  # };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*" = {
      addKeysToAgent = "yes";
      identitiesOnly = "yes";
      identityFile = "~/.ssh/id_ed25519";
    };
    extraConfig = ''
      # Global PKCS11Provider for all hosts
      PKCS11Provider /run/current-system/sw/lib/opensc-pkcs11.so

      Host github.com
        HostName github.com
        User git

      Host gitea.taile9a1d6.ts.net
        HostName gitea.taile9a1d6.ts.net
        User git

      Host homelab-ts
        Hostname 100.99.179.98
        Port 22
        User benvl
      Host alpine-ts
        Hostname 100.68.51.33
        Port 22
        User root
      Host homelab
        Hostname 192.168.50.117
        Port 22
        User benvl
      Host alpine
        Hostname 192.168.50.222
        Port 22
        User root
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
}

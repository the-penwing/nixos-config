{...}: {
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
}

# Home shell/developer ergonomics module.
#
# Purpose:
# - Keep per-user shell tooling and environment variables together
# - Manage direnv, starship, and fzf declaratively via home-manager
# - Keep SSH agent behaviour explicit and auditable
{ pkgs, ... }:

{
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

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*" = {
      addKeysToAgent = "yes";
      identityFile = "~/.ssh/id_ed25519";
    };
  };
  programs.git = {
    enable = true;
    extraConfig = {
      credential.helper = "!pass-git-helper $@";
    };
  };
  # Define how Git hosts map to entries inside your password-store (~/.password-store/)
  xdg.configFile."pass-git-helper/git-pass-mapping.ini".text = ''
    [github.com]
    target=dev/github
  '';
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses; # Forces a TTY prompt that works safely in the background
  };
}

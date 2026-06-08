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

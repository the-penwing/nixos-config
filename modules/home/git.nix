{pkgs, ...}: {
  home.packages = with pkgs; [
    pass-git-helper
  ];
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

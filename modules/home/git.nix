{pkgs, ...}: {
  home.packages = with pkgs; [
    pass-git-helper
    delta
    git-lfs
  ];

  programs.git = {
    enable = true;
    signing = {
      key = "3949612C4B58A93F3DCD7488A11420689178B907";
      signByDefault = true;
    };
    settings = {
      user = {
        name = "Ben van Leeuwen";
        email = "thepenwing@gmail.com";
      };
      core = {
        autocrlf = false;
        eol = "lf";
        pager = "delta";
      };
      delta = {
        navigate = true;
        dark = true;
      };
      alias = {
        rdiff = "!git --no-pager diff";
        rshow = "!git --no-pager show";
        patch = "!git --no-pager diff";
        stage-rename = "!f() { git ls-files -s \"$1\" | sd \"(\\t)$1$\" \"\\$1$2\" | git update-index --index-info && git rm --cached \"$1\"; }; f";
      };
      "filter \"lfs\"" = {
        process = "git-lfs filter-process";
        required = "true";
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
      };
      gpg.format = "openpgp";
      credential.helper = "!pass-git-helper $@";
      init.defaultBranch = "main";
      merge.conflictStyle = "zdiff3";
      interactive.diffFilter = "delta --color-only";
    };
  };
}

{...}: {
  programs.gpg = {
    enable = true;
    settings = {
      auto-key-locate = "keyserver";
    };
  };
  services.gpg-agent = {
    enable = true;
  };
  home.file.".gnupg/dirmngr.conf".text = ''
    keyserver hkps://keys.openpgp.org
  '';
}

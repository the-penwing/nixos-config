{inputs, ...}: {
  imports = [inputs.blip.nixosModules.default];
  programs.blip = {
    enable = true;
    autostart.enable = true;
  };
}

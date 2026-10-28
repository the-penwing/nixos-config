# modules/system/nixpkgs.nix
{
  inputs,
  system,
  ...
}: {
  nixpkgs = {
    overlays =
      (import ../../overlays/default.nix)
      ++ [
        inputs.ghostty.overlays.default
        inputs.rust-overlay.overlays.default
        inputs.bacon.overlay.${system}
        inputs.bacon-ls.overlay.${system}
      ];
    config = {
      allowUnfree = true;
      android_sdk.accept_license = true;
    };
  };
}

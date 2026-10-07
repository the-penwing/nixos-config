# Home module entrypoint.
#
# Purpose:
# - Keep module imports explicit and easy to audit
{...}: {
  imports = [
    ./ghostty.nix
    ./shell.nix
    ./atuin.nix
    ./starship.nix
    ./fastfetch.nix
    ./tmux.nix
    ./helix.nix
    ./desktop.nix
  ];
}

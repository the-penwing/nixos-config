# Home module entrypoint.
#
# Purpose:
# - Keep module imports explicit and easy to audit
{...}: {
  imports = [
    ./shell.nix
    ./atuin.nix
    ./starship.nix
    ./fastfetch.nix
    ./tmux.nix
    ./desktop.nix
  ];
}

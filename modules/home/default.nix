# Home module entrypoint.
#
# Purpose:
# - Keep module imports explicit and easy to audit
{ ... }:

{
  imports = [
    ./shell.nix
    ./tmux.nix
    ./desktop.nix
  ];
}

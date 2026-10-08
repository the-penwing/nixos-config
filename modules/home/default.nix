# Home module entrypoint.
{...}: {
  imports = [
    ./ashell.nix
    ./atuin.nix
    ./desktop.nix
    ./direnv.nix
    ./fastfetch.nix
    ./ghostty.nix
    ./git.nix
    ./helix.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
    ./zoxide.nix
    ./zsh.nix
  ];
}

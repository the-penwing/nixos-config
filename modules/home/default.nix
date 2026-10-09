# Home module entrypoint.
{...}: {
  imports = [
    ./ashell.nix
    ./atuin.nix
    ./desktop.nix
    ./direnv.nix
    ./fastfetch.nix
    ./fzf.nix
    ./ghostty.nix
    ./git.nix
    ./helix.nix
    ./hyprland.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
    ./zoxide.nix
    ./zsh.nix
  ];
}

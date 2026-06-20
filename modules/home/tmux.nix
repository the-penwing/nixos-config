{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    clock24 = true;
    mouse = true;
    historyLimit = 20000;
    terminal = "tmux-256color";

    plugins = with pkgs; [
      tmuxPlugins.cpu
      tmuxPlugins.yank
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.sensible
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60'
        '';
      }
      tmuxPlugins.harpoon
    ];

    extraConfig = ''
      set -g renumber-windows on
    '';
  };
}

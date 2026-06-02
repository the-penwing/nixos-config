{ pkgs }:
{
  packages = with pkgs; [
    bashInteractive
    bash-completion
    shellcheck
    shfmt
    bats
    jq
    yq-go
    bash-language-server
  ];
  shellHook = ''
    eval "$(${pkgs.zoxide}/bin/zoxide init bash)"

    alias cat='bat --paging=never'
    alias ls='eza'
    alias ll='eza --icons -l'
    alias la='eza --icons -la'
    alias grep='rg'
    alias find='fd'
    alias du='dust'
    alias df='duf'
    alias ps='btop'
    alias cd='z'

    echo "bash-scripting dev shell loaded"
    echo "Tooling: shellcheck, shfmt, bats, bash-language-server"
  '';
}

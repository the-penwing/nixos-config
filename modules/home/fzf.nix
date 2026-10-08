{...}: {
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    historyWidget.command = "";
    defaultCommand = "fd";
    defaultOptions = [
      "--color=dark"
      "--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f"
      "--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7"
      "--style default"
      "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
    ];
  };
}

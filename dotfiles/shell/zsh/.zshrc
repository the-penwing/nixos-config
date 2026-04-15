# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

#ZSH_THEME="classyTouch"
ZSH_THEME=""

ENABLE_CORRECTION="true"

plugins=( 
    zsh-autosuggestions
    git
    zsh-syntax-highlighting
    fzf
    zsh-interactive-cd
)
export PATH="$HOME/.local/bin:$PATH"

eval "$(direnv hook zsh)"

# SSH agent auto-start and cache passphrase
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)" > /dev/null
fi
ssh-add ~/.ssh/id_ed25519 2>/dev/null

# Node (global via NixOS)
export PATH="$PATH:$HOME/.npm-global/bin"

# Rust/Cargo (via NixOS rustup)
export PATH="$PATH:$HOME/.cargo/bin"

# NeoVim (installed via NixOS packages)
export SUDO_EDITOR=$(which nvim)
export EDITOR=$(which nvim)

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_BASE=~/.fzf/
export FZF_DEFAULT_COMMAND='fd'
DISABLE_FZF_AUTO_COMPLETION="false"
DISABLE_FZF_KEY_BINDINGS="false"

# Starship 
eval "$(starship init zsh)"

# oh-my-zsh — must be near end
source $ZSH/oh-my-zsh.sh

alias python3='python3.14'
alias python='python3.14'
alias pip='uv pip'
alias tlp-perf='sudo tlp ac'
alias tlp-save='sudo tlp bat'

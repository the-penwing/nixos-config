# ============================================================================
# Environment Variables
# ============================================================================
# CORE
export BAT_THEME="Dracula"
export FZF_BASE="$HOME/.fzf"
export FZF_DEFAULT_COMMAND="fd"
export FZF_DEFAULT_OPTS="--color=dark \
  --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f \
  --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7 \
  --style default \
  --preview 'bat --style=numbers --color=always --line-range :500 {}'"
export DISABLE_FZF_AUTO_COMPLETION="false"
export DISABLE_FZF_KEY_BINDINGS="false"
export TIMEFMT=$'\nreal %*E\nuser %*U\nsys %*S\n'
# SYSTEM SPECIFIC
export PATH="$PATH:$HOME/nixos-config/scripts:$HOME/.cargo/bin"
# SDKs
export SDKROOT="/home/benvl/dev/resources/SDKs/MacOSX15.5.sdk"
export PICO_SDK_PATH="/home/benvl/dev/hardware/pico2/cc/pico-sdk"
# WM / DE
export BEMOJI_PICKER_CMD="fuzzel -d"
export GPG_TTY=$(tty)
# ============================================================================
# History Management
# ============================================================================
export HISTSIZE=50000
export SAVEHIST=50000
export HISTFILE=~/.zsh_history

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

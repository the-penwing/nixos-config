# ============================================================================
# Environment Variables
# ============================================================================
export FZF_BASE="$HOME/.fzf"
export FZF_DEFAULT_COMMAND="fd"
export DISABLE_FZF_AUTO_COMPLETION="false"
export DISABLE_FZF_KEY_BINDINGS="false"
export FZF_DEFAULT_OPTS="--color=dark \
  --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f \
  --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7 \
  --style default \
  --preview 'bat --style=numbers --color=always --line-range :500 {}'"
export TIMEFMT=$'\nreal %*E\nuser %*U\nsys %*S\n'
export BAT_THEME="Dracula"
export SDKROOT="/home/benvl/dev/resources/SDKs/MacOSX26.1.sdk"
export GPG_TTY=$(tty)
export PATH="$PATH:$HOME/.npm-global/bin:$HOME/.cargo/bin:$HOME/nixos-config/scripts"
export XDG_DATA_DIRS="$HOME/.local/share:$XDG_DATA_DIRS"

# ============================================================================
# History Management - Env Vars and Opts 
# ============================================================================
# Size Settings
export HISTSIZE=50000          # Lines loaded into memory per session
export SAVEHIST=50000          # Lines saved to the history file on disk
export HISTFILE=~/.zsh_history

# Smart Trimming & Sharing
setopt HIST_IGNORE_DUPS        # Don't record a command if it was just run
setopt HIST_IGNORE_ALL_DUPS    # Don't Record ANY dupes
setopt HIST_IGNORE_SPACE       # Don't record lines starting with a space
setopt HIST_EXPIRE_DUPS_FIRST  # Expire duplicate entries first when trimming
setopt INC_APPEND_HISTORY      # Write to history file immediately, not on exit
setopt SHARE_HISTORY           # Share history across all active terminals

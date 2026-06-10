# ============================================================================
# Environment Variables — Minimal exports only
# ============================================================================
export PATH="$HOME/.local/bin:$PATH:$HOME/.npm-global/bin:$HOME/.cargo/bin"
export npm_config_prefix="$HOME/.npm-global"
export SUDO_EDITOR="nvim"
export EDITOR="nvim"
export FZF_BASE="$HOME/.fzf"
export FZF_DEFAULT_COMMAND="fd"
export DISABLE_FZF_AUTO_COMPLETION="true"
export DISABLE_FZF_KEY_BINDINGS="false"
export FZF_DEFAULT_OPTS="--color=dark --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7 --style full --preview 'bat --style=numbers --color=always --line-range :500 {}'"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent"
export GPG_TTY="$(tty)"
export TIMEFMT=$'\nreal %*E\nuser %*U\nsys %*S\n'
export BAT_THEME="Dracula"
export DOCKER_HOST="unix:///run/user/1000/podman/podman.sock"

# i686 Musl Linux (iSH)
export CARGO_TARGET_I686_UNKNOWN_LINUX_MUSL_LINKER="zig-linker-i686-musl"

# aarch64 GNU Linux (RPi)
export CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER="zig-linker-aarch64-gnu"

# aarch64 Musl Linux (Alpine RPi)
export CARGO_TARGET_AARCH64_UNKNOWN_LINUX_MUSL_LINKER="zig-linker-aarch64-musl"

# x86_64 Windows GNU
export CARGO_TARGET_X86_64_PC_WINDOWS_GNU_LINKER="zig-linker-x86_64-windows"

# aarch64 macOS (Apple Silicon)
export CARGO_TARGET_AARCH64_APPLE_DARWIN_LINKER="zig-linker-aarch64-macos"

# x86_64 macOS (Intel)
export CARGO_TARGET_X86_64_APPLE_DARWIN_LINKER="zig-linker-x86_64-macos"

# x86_64 Linux (Standard glibc)
export CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER="zig-linker-x86_64-gnu"

# x86_64 Linux (Static musl)
export CARGO_TARGET_X86_64_UNKNOWN_LINUX_MUSL_LINKER="zig-linker-x86_64-musl"


# nixos-config

Personal NixOS configuration for `nixos-laptop` — a Wayland-only setup built on Hyprland, managed entirely with flakes and home-manager.


## Quick start

```bash
# Full system rebuild (system + home)
sudo nixos-rebuild switch --flake .#nixos-laptop

# Home-manager only (no sudo required)
home-manager switch --flake .#nixos-laptop
```


## File layout

```
nixos-config/
  flake.nix                   # entry point; all inputs & nixos-laptop output
  home.nix                    # home-manager entry

  hosts/nixos-laptop/
    configuration.nix         # system entry point
    hardware-configuration.nix

  modules/
    system/                   # boot, networking, hardware, services, packages, input
    home/                     # shell, editor, desktop

  dotfiles/
    desktop/                  # hyprland, waybar, wofi, rofi, wlogout
    shell/                    # zsh, starship, tmux
    editor/                   # nvim (LazyVim)
    apps/                     # ghostty, btop, fastfetch, lazygit, waypaper, nm-dmenu
    theme/                    # gtk, dunst
```


## Config approach

| Layer | Tool | Description |
|---|---|---|
| System | NixOS flake | Declarative OS config — bootloader, kernel, services, system packages |
| Home | home-manager | Per-user dotfiles, shell, editor, desktop app config |
| Dotfiles | Plain config files | Symlinked by home-manager into `~/.config/` |
| Key remapping | keyd | Kernel-level remapping applied before Hyprland sees any key event |
| Wayland compositor | Hyprland | Application keybindings, window rules, workspace management |

### Two-layer input system

Key remapping is split between **keyd** (kernel level) and **Hyprland** (compositor level) to keep concerns separated:

- **keyd** (`modules/system/input.nix`) handles universal remaps that should work in every app regardless of focus — Caps Lock layer, `Super+Z/X/A` editing shortcuts.
- **Hyprland** (`dotfiles/desktop/hyprland/hyprland.conf`) handles everything compositor-specific — launching apps, window management, workspace switching.

### Desktop session

There is no display manager. TTY1 auto-logs in as `benvl` and `.zshrc` starts Hyprland automatically.


## Keybindings

> **Super** = Windows / Command key  
> **Note:** `Super+L` is reserved for **lock screen**. Focus right is on `Super+→` or `Alt+Tab`.

### Super layer — app launchers & window management

| Shortcut | Action |
|---|---|
| `Super + Enter` | Open Ghostty terminal |
| `Super + M` | Open Ghostty terminal |
| `Super + B` | Open Firefox |
| `Super + E` | Open Nautilus file manager |
| `Super + N` | Open Obsidian |
| `Super + R` | Open app launcher (wofi drun) |
| `Super + C` | Open clipboard history picker |
| `Super + Q` | Close active window |
| `Super + Shift + Q` | Exit Hyprland |
| `Super + F` | Toggle fullscreen |
| `Super + Shift + F` | Toggle fullscreen (maximise only) |
| `Super + V` | Toggle floating |
| `Super + T` | Toggle split direction |
| `Super + P` | Pin window (keep on top across workspaces) |
| `Super + L` | Lock screen (hyprlock) |
| `Super + \`` | Session menu (wlogout) |
| `Super + S` | Toggle special workspace |
| `Super + Shift + S` | Move window to special workspace (silently) |

### Navigation & window movement

| Shortcut | Action |
|---|---|
| `Super + H / J / K` | Move focus left / down / up |
| `Super + ← / → / ↑ / ↓` | Move focus (arrow keys, all directions incl. right) |
| `Super + Shift + H / J / K` | Move window left / down / up |
| `Super + Shift + ← / → / ↑ / ↓` | Move window (arrow keys) |
| `Super + Alt + H / J / K` | Resize window left / down / up |
| `Super + Alt + ← / → / ↑ / ↓` | Resize window (arrow keys) |
| `Alt + Tab` | Cycle windows forward |
| `Alt + Shift + Tab` | Cycle windows backward |

### Workspaces

| Shortcut | Action |
|---|---|
| `Super + 1–9, 0` | Switch to workspace 1–10 |
| `Super + Shift + 1–9, 0` | Move window to workspace 1–10 |
| `Super + Scroll Up/Down` | Scroll through workspaces |

### Screenshots

| Shortcut | Action |
|---|---|
| `Print` | Region screenshot → clipboard |
| `Shift + Print` | Full screenshot → `~/Pictures/Screenshots/` |
| `Super + Print` | Region screenshot → `~/Pictures/Screenshots/` |

### Media & brightness (hardware keys)

| Key | Action |
|---|---|
| `XF86AudioRaiseVolume` | Volume +5% |
| `XF86AudioLowerVolume` | Volume −5% |
| `XF86AudioMute` | Toggle mute |
| `XF86AudioPlay` | Play / pause |
| `XF86AudioNext` | Next track |
| `XF86AudioPrev` | Previous track |
| `XF86MonBrightnessUp` | Brightness +5% |
| `XF86MonBrightnessDown` | Brightness −5% |

### Mouse

| Action | Binding |
|---|---|
| Move window | `Super + Left-drag` |
| Resize window | `Super + Right-drag` |

### Touchpad gestures

| Gesture | Action |
|---|---|
| 3-finger swipe left/right | Switch workspace |
| 3-finger swipe up | Toggle special workspace |


## Caps Lock layer (keyd)

Caps Lock is remapped at the kernel level via **keyd**:

- **Tap** → `Escape` (useful in Neovim)
- **Hold** → activates the layer below

| Caps Lock + key | Action |
|---|---|
| `Space` | Play / pause |
| `,` | Previous track |
| `.` | Next track |
| `M` | Mute |
| `←` | Volume down |
| `→` | Volume up |
| `↑` | Brightness up |
| `↓` | Brightness down |
| `C` | `Ctrl+C` — interrupt process |
| `D` | `Ctrl+D` — EOF / exit shell |
| `Z` | `Ctrl+Z` — suspend process |
| `L` | `Ctrl+L` — clear screen |
| `U` | `Ctrl+U` — clear line |
| `A` | `Ctrl+A` — jump to start of line |
| `E` | `Ctrl+E` — jump to end of line |
| `K` | `Ctrl+K` — delete to end of line |
| `W` | `Ctrl+W` — delete word back |
| `Q` | Open session menu (wlogout) |

### keyd universal remaps (main layer)

These work in any focused app, system-wide:

| Shortcut | Action |
|---|---|
| `Super + Z` | Undo (`Ctrl+Z`) |
| `Super + X` | Cut (`Ctrl+X`) |
| `Super + A` | Select all (`Ctrl+A`) |


## Features

### Desktop
- **Hyprland** — tiling Wayland compositor with dwindle layout, smart split/resize
- **Waybar** — status bar
- **Wofi** — primary app launcher (drun mode)
- **Rofi** — alternative launcher
- **Dunst** — notifications (Gruvbox-themed)
- **Hyprlock** — lock screen
- **Hypridle** — automatic DPMS / screen lock on idle
- **Waypaper** — wallpaper picker (restores wallpaper on login)
- **wlogout** — graphical session / power menu
- **Bibata Modern Classic** — cursor theme

### Shell
- **Zsh** — default shell, launched from TTY autologin
- **Starship** — shell prompt
- **Tmux** — terminal multiplexer

### Editor
- **Neovim** — primary editor configured with LazyVim
- **Micro** — fallback terminal editor

### Theme
- **Gruvbox Dark** — GTK theme (`gruvbox-dark-gtk`)
- **Gruvbox Plus** — icon pack

### Audio
- **Pipewire** — audio server (48 kHz, replaces PulseAudio)
- **pamixer** — CLI volume control
- **pavucontrol** — GUI mixer
- **playerctl** — MPRIS media control
- **mpris-scrobbler** — ListenBrainz scrobbling (systemd user service)

### Networking
- **NetworkManager** — network management + tray applet
- **Tailscale** — VPN / remote access (replaces SSH on open ports)
- **Syncthing** — file sync (socket-activated, not started at boot)
- **Blueman** — Bluetooth manager

### Productivity
- **Obsidian** — note-taking
- **Thunderbird** — email
- **LibreOffice** — office suite
- **Bitwarden** — password manager

### Developer tools
- **Git**, **Lazygit** — version control
- **Docker** — containers (socket-activated)
- **Node.js**, **Python 3**, **Rust** (rustup), **GCC** — language toolchains
- **fzf**, **ripgrep**, **fd**, **bat**, **eza**, **jq** — CLI utilities
- **Solaar** — Logitech peripheral manager (Logi Pebble 2 support)


## Flake inputs

| Input | Source |
|---|---|
| `nixpkgs` | `nixos-unstable` |
| `home-manager` | `master` (follows nixpkgs) |
| `naviterm` | `gitlab:detoxify92/naviterm` |
| `plank-reloaded` | `github:zquestz/plank-reloaded` |
| `solaar` | FlakeHub stable |
| `iloader` | `github:nab138/iloader` |


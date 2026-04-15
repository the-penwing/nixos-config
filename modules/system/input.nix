{ ... }:

{
  # ============================================================
  # INPUT — keyd kernel-level key remapping
  # Works on all connected keyboards (built-in + Logi Pebble 2)
  # ============================================================

  # Helper script: runs a command inside the user's active Wayland session.
  # keyd runs as root, so GUI apps need the user's Wayland socket and D-Bus.
  #
  # Username and UID: this config is for the single-user setup defined in
  # packages.nix (users.users.benvl, UID 1000).  Adjust if your username
  # or UID differs.
  #
  # WAYLAND_DISPLAY: Hyprland started from .zshrc on TTY1 (see services.nix)
  # always gets "wayland-1".  If you switch to a display manager the display
  # name may become "wayland-0" — update this value accordingly.
  environment.etc."keyd/user-exec.sh" = {
    mode = "0755";
    text = ''
      #!/bin/sh
      exec /run/wrappers/bin/su - benvl -c \
        "WAYLAND_DISPLAY=wayland-1 XDG_RUNTIME_DIR=/run/user/1000 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus $*"
    '';
  };

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        # Apply to every connected keyboard (built-in + Logi Pebble 2)
        ids = [ "*" ];
        settings = {
          main = {
            # ── Universal Commands ────────────────────────────────
            # Super+key → standard shortcuts that work in every app
            "super+c" = "C-c";       # Copy
            "super+v" = "C-v";       # Paste
            "super+z" = "C-z";       # Undo
            "super+x" = "C-x";       # Cut
            "super+a" = "C-a";       # Select all
            "super+s" = "C-s";       # Save
            "super+q" = "A-f4";      # Quit / close window

            # ── App Launchers ─────────────────────────────────────
            # Super+number / Super+E → launch frequently used apps.
            # All apps referenced here are installed via packages.nix.
            # Tip: add `bind = ALT, F4, killactive` to hyprland.conf
            # so Super+Q also closes Hyprland-managed windows.
            "super+1" = "cmd(/etc/keyd/user-exec.sh ghostty &)";
            "super+2" = "cmd(/etc/keyd/user-exec.sh firefox &)";
            "super+3" = "cmd(/etc/keyd/user-exec.sh nautilus &)";
            "super+4" = "cmd(/etc/keyd/user-exec.sh ghostty -e nvim &)";
            "super+5" = "cmd(/etc/keyd/user-exec.sh discord &)";
            "super+e" = "cmd(/etc/keyd/user-exec.sh rofi -show drun &)";
          };

          # ── Navigation & Media Layer (hold Right Alt) ──────────
          # Keep Right Alt held and press the keys below.
          "nav:rightalt" = {
            # Vim-style arrow navigation
            h = "left";
            j = "down";
            k = "up";
            l = "right";

            # Page and line navigation
            u = "pageup";
            d = "pagedown";
            b = "home";
            e = "end";

            # Media controls (via playerctl — needs user D-Bus session)
            p     = "cmd(/etc/keyd/user-exec.sh playerctl play-pause)";
            comma = "cmd(/etc/keyd/user-exec.sh playerctl previous)";
            dot   = "cmd(/etc/keyd/user-exec.sh playerctl next)";

            # Volume controls (via pamixer — needs user PipeWire session)
            minus = "cmd(/etc/keyd/user-exec.sh pamixer -d 5)";
            equal = "cmd(/etc/keyd/user-exec.sh pamixer -i 5)";
            m     = "cmd(/etc/keyd/user-exec.sh pamixer -t)";

            # Brightness controls (via brightnessctl — kernel interface, runs as root)
            leftbrace  = "cmd(brightnessctl s 10%-)";
            rightbrace = "cmd(brightnessctl s +10%)";
          };
        };
      };
    };
  };
}

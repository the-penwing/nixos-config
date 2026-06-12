{ ... }:

{
  # ============================================================
  # INPUT — keyd kernel-level key remapping
  # Works on all connected keyboards (built-in + Logi Pebble 2)
  #
  # Scope is intentionally narrow to avoid conflicting with the
  # existing Hyprland bindings in hyprland.conf.  Specifically:
  #
  #   Excluded (already bound in Hyprland):
  #     Super+C  → cliphist picker
  #     Super+V  → togglefloating
  #     Super+S  → special workspace
  #     Super+Q  → killactive
  #     Super+E  → dolphin
  #     Super+1–9,0 → workspace switching
  #     Right Alt → compose key (kb_options = compose:ralt)
  #     XF86 media / brightness → already handled by Hyprland
  #
  #   Remapped here (universal layer helpers):
  #     Super+Z → Ctrl+Z  (undo — universal in every app)
  #     Super+X → Ctrl+X  (cut  — universal in every app)
  #     Super+A → Ctrl+A  (select-all — universal in every app)
  #
  # Caps Lock layer
  # ──────────────
  #   Tap  → Escape  (great for neovim)
  #   Hold → activate the [capslock] layer below
  #
  #   Media:       Space=play/pause   ,=prev   .=next   M=mute
  #   Volume:      Left=vol-down      Right=vol-up
  #   Brightness:  Up=bright+         Down=bright-
  #   Terminal:    C=^C  D=^D  Z=^Z  L=^L  U=^U  A=^A  E=^E  K=^K  W=^W
  #   Session:     Q → Super+R which Hyprland binds to Caelestia launcher
  # ============================================================
  environment.etc."keymaps/disable-alt-arrows.map".text = ''
    alt keycode 105 = nul
    alt keycode 106 = nul
  '';
  console.keyMap = "disable-alt-arrows";

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        # Apply to every connected keyboard (built-in + Logi Pebble 2)
        ids = [ "*" ];
        settings = {
          main = {
            # Caps Lock: tap = Escape, hold = caps lock layer
            capslock = "overload(capslock, esc)";

            # Universal edits — remapped before Hyprland sees them,
            # so they work in any focused app (terminal, browser, etc.)
            "super+z" = "C-z";   # Undo
            "super+x" = "C-x";   # Cut
            "super+a" = "C-a";   # Select all
          };

          # ── Caps Lock held layer ──────────────────────────────
          "capslock" = {
            # Media controls
            space = "playpause";
            "," = "previoussong";
            "." = "nextsong";
            m = "mute";

            # Volume (arrow left/right)
            left = "volumedown";
            right = "volumeup";

            # Brightness (arrow up/down)
            up = "brightnessup";
            down = "brightnessdown";

            # Terminal shortcuts
            c = "C-c";   # Interrupt
            d = "C-d";   # EOF / logout shell
            z = "C-z";   # Suspend process
            l = "C-l";   # Clear screen
            u = "C-u";   # Clear line
            a = "C-a";   # Jump to start of line
            e = "C-e";   # Jump to end of line
            k = "C-k";   # Delete to end of line
            w = "C-w";   # Delete word back

            # Session launcher — sends Super+R which Hyprland maps to Caelestia launcher
            q = "M-r";
          };
        };
      };
    };
  };
}

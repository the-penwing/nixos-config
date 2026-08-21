{...}: {
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = ["*"];
        settings = {
          main = {
            # Caps Lock: tap = Escape, hold = caps lock layer
            capslock = "overload(capslock, esc)";
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
            c = "C-c"; # Interrupt
            d = "C-d"; # EOF / logout shell
            z = "C-z"; # Suspend process
            l = "C-l"; # Clear screen
            u = "C-u"; # Clear line
            a = "C-a"; # Jump to start of line
            e = "C-e"; # Jump to end of line
            k = "C-k"; # Delete to end of line
            w = "C-w"; # Delete word back

            # App launcher
            r = "M-r";
          };
        };
      };
    };
  };
}

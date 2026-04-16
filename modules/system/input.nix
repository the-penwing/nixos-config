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
  #     Super+E  → nautilus
  #     Super+1–5 → workspace switching
  #     Right Alt → compose key (kb_options = compose:ralt)
  #     XF86 media / brightness → already handled by Hyprland
  #
  #   Safe to remap (no Hyprland binding):
  #     Super+Z → Ctrl+Z  (undo — universal in every app)
  #     Super+X → Ctrl+X  (cut  — universal in every app)
  #     Super+A → Ctrl+A  (select-all — universal in every app)
  # ============================================================
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        # Apply to every connected keyboard (built-in + Logi Pebble 2)
        ids = [ "*" ];
        settings = {
          main = {
            # Universal edits — remapped before Hyprland sees them,
            # so they work in any focused app (terminal, browser, etc.)
            "super+z" = "C-z";   # Undo
            "super+x" = "C-x";   # Cut
            "super+a" = "C-a";   # Select all
          };
        };
      };
    };
  };
}

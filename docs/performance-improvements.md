# Performance improvement notes

This document tracks practical places to improve speed, responsiveness, and battery life over time.

## 1) Nix build/eval performance

- **Pin and review heavy flake inputs regularly**: external flake inputs can increase evaluation time and closure size.
- **Use targeted rebuilds while iterating**: prefer `nixos-rebuild test --flake .#nixos-t14s` for fast checks before full `switch`.
- **Keep garbage collection tuned to usage**: current GC is aggressive (`--delete-older-than 2d`). If rollback churn is low, this is good for disk pressure; if churn grows, consider age+count hybrid retention.

## 2) Hyprland responsiveness

- **Animation cost tuning**: `animations` and `blur` are visually nice but consume GPU on integrated graphics. If frame pacing drops on battery, reduce blur size/passes first.
- **Virtual monitor profiles**: loading high-resolution virtual outputs when unused increases composition overhead. Keep virtual monitor entries disabled unless streaming.
- **Window-rule review**: keep rules minimal and remove stale app-specific rules to reduce config complexity and troubleshooting time.

## 3) Startup/login latency

- **Autostart budgeting**: each `exec-once` command adds startup work. Profile shell start + Hyprland first frame, then delay non-critical background tools.
- **Shell modularization**: startup is now split in `zshrc.d`; this makes it easier to measure and optimize each part independently.
- **SSH key loading**: loading keys on every shell start is convenient; if startup gets slow, gate `ssh-add` behind an interactive check.

## 4) Package and closure hygiene

- **Remove duplicate declarations**: avoid declaring the same utility in both system and home scopes.
- **Track superseded packages**: prefer renamed/replacement packages in nixpkgs when deprecations appear.
- **Periodically trim low-use GUI apps**: large GUI packages can inflate rebuild/download sizes.

## 5) Development shell ergonomics vs speed

- **Keep shell defaults lean**: put heavy tools in task-specific shells (`microbit-*`, `bash-scripting`) rather than global shell packages.
- **Prefer language-server-on-demand**: run heavy background tooling only in active project shells.

## 6) Ongoing review checklist

Run this quick review monthly:

1. `nix flake check --no-build`
2. Review `modules/system/packages.nix` and `modules/home/*.nix` for duplicates
3. Review `dotfiles/desktop/hyprland/supercoolconfig/*.lua` for stale binds/rules
4. Verify `docs/` still matches actual module and dotfile layout

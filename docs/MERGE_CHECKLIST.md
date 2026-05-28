# Pre-Merge Checklist — Second Pass

## Code quality
- [ ] `nix flake check --no-build` passes
- [ ] `nix fmt` applied to all `.nix` files
- [ ] No syntax errors in shell scripts

## Content verification
- [ ] No `thunar` references (except git history)
- [ ] `modules/home/shell.nix` includes direnv, starship, fzf programs
- [ ] `dotfiles/shell/zsh/zshrc.d/20-integrations.zsh` has Yazi `yy` function only
- [ ] `modules/system/desktop.nix` has `security.polkit.enable = true`
- [ ] `packages.nix` still has direnv, starship, fzf in appropriate categories

## Testing
- [ ] `./scripts/rebuild --dry-run` shows expected changes
- [ ] `./scripts/rebuild` completes successfully
- [ ] System boots without errors
- [ ] Hyprland launches correctly
- [ ] `fm` opens Yazi with correct keybinds
- [ ] `Super+E` opens Dolphin
- [ ] Shell reloads and direnv/starship/fzf work
- [ ] `xdg-mime query default inode/directory` returns dolphin.desktop
- [ ] `zramctl status` shows zram enabled
- [ ] `cat /proc/sys/vm/swappiness` returns 20
- [ ] `./scripts/rollback` works and system boots

## Documentation
- [ ] `docs/validation.md` is complete and clear
- [ ] `docs/rollback-workflow.md` is complete
- [ ] Commit messages are descriptive (conventional commits style)
- [ ] README still accurate after changes

## Final approval
- [ ] All checks above pass ✓
- [ ] Ready to merge

---

**Sign-off**: _______________  Date: ___________

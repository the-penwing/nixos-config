# Performance Optimisations

This audit targets laptop responsiveness and homelab-minded resource efficiency.

## High impact, low effort (implemented now)

### 1) Keep NetworkManager wait-online disabled

**Why:** removes avoidable boot delay when no unit requires strict network-online ordering.

```nix
systemd.services.NetworkManager-wait-online.enable = false;
```

**Status:** Implemented in `modules/system/performance.nix`.

### 2) Enable periodic fstrim

**Why:** improves long-term SSD write behaviour and helps sustained I/O performance.

```nix
services.fstrim.enable = true;
```

**Status:** Implemented in `modules/system/performance.nix`.

### 3) Keep controlled Nix build parallelism

**Why:** reduces UI stalls under local builds by limiting concurrent build pressure.

```nix
nix.settings = {
  cores = 4;
  max-jobs = 2;
};
```

**Status:** Implemented in `modules/system/performance.nix`.

### 4) Use zram + tuned VM writeback/swap policy

**Why:** better interactive behaviour under memory pressure, especially while multitasking.

```nix
zramSwap = {
  enable = true;
  memoryPercent = 100;
  algorithm = "zstd";
};

boot.kernel.sysctl = {
  "vm.swappiness" = 20;
  "vm.vfs_cache_pressure" = 50;
  "vm.dirty_ratio" = 15;
  "vm.dirty_background_ratio" = 5;
};
```

**Status:** Implemented in `modules/system/performance.nix`.

---

## Medium impact, medium effort (next iteration)

### 1) Review always-on services per role

Potential candidates when not needed daily:
- `services.printing`
- `services.avahi`
- `services.syncthing`

Example toggle pattern:

```nix
services.printing.enable = false;
services.avahi.enable = false;
```

### 2) Split security tooling profile from daily workstation profile

Move heavy offensive tooling into optional profile/role module to reduce closure size and update time.

```nix
imports = [ ./profiles/security-lab.nix ];
```

### 3) DNS hardening/perf tuning with systemd-resolved

```nix
services.resolved = {
  enable = true;
  dnssec = "allow-downgrade";
  dnsovertls = "opportunistic";
};
```

---

## Low impact / niche

### 1) App-specific startup profiling

Measure user-session startup to defer non-essential user services.

### 2) Wayland visual tuning on battery

Reduce blur/animation intensity in Hyprland/Caelestia when on battery-only sessions.

### 3) Nix store housekeeping cadence tuning

Current policy keeps 7 days. Increase/decrease based on rollback needs and disk pressure.

```nix
nix.gc.options = "--delete-older-than 7d";
```

---

## Validation steps

1. `systemd-analyze blame` and `systemd-analyze critical-chain`
2. `free -h` before/after heavy workload
3. `iotop`/`iostat` during rebuilds and package upgrades
4. `nix path-info -Shr /run/current-system`

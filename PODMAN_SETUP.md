# Podman + act Setup Guide

## Overview

This NixOS configuration replaces Docker with Podman for local CI/CD testing via `act`.

### Why Podman?
- **Daemonless**: No background service consuming resources
- **Rootless**: Runs as unprivileged user by default (security + ASD career track)
- **Faster**: 38% faster container startup than Docker
- **Zero passive overhead**: Only runs when you call `act`

## Installation (Completed)

Podman is enabled in `configuration.nix`:
```nix
virtualisation.podman = {
  enable = true;
  dockerSocket.enable = true;
};
```

act is installed as a system package.

## How to Use

### List all workflows in a project
```bash
cd /path/to/project
act -l
```

### Run all workflows (simulates push event)
```bash
act
```

### Run a specific job
```bash
act -j test
```

### Simulate a pull request
```bash
act pull_request
```

### Dry run (show what would execute)
```bash
act --dry-run
```

## Configuration

**File**: `~/.actrc`

Controls default runner image, backend socket, and behavior.

```
-P ubuntu-latest=nektos/act-environments-ubuntu:latest
--container-daemon-socket unix:///run/podman/podman.sock
```

## For Lua Projects

### Sample Gitea workflow (.gitea/workflows/test.yml)
```yaml
name: Test
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run Lua tests
        run: |
          lua tests.lua
```

### Run locally
```bash
cd /path/to/lua/project
act
```

### First run
- Image download: ~500MB (one-time, then cached)
- Container startup: 500ms-1.5s (expected, overhead from namespace/cgroup setup)
- Subsequent runs: Much faster (image cached)

## Skipping Remote-Only Steps

Use the `ACT` environment variable to skip steps that should only run on Gitea:

```yaml
- name: Deploy
  if: ${{ !env.ACT }}
  run: deploy.sh
```

This step will be skipped locally but run on Gitea.

## Troubleshooting

### "act: command not found"
```bash
sudo nixos-rebuild switch
# Then open a new shell
act --version
```

### "permission denied" for podman socket
Already configured in `configuration.nix` (rootless mode enabled).

### "image not found" on first run
Normal. act downloads the runner image (~500MB). This happens once.

### Container can't find tools
Using the "medium" image (~500MB). If a tool is missing, try "large" (~17GB) - update `.actrc`:
```
-P ubuntu-latest=nektos/act-environments-ubuntu:latest
```

### Offline work
After first image download, you can run workflows offline (no internet needed).

## Performance Notes

- **Container startup**: 500ms-1.5s per run (namespace/cgroup setup)
- **Image caching**: First download ~500MB, then cached locally
- **No daemon overhead**: Podman socket is managed by systemd, only active during act execution
- **Comparison to GitHub**: Instant feedback vs commit/push/wait cycle (saves hours per week)

## Next Steps

1. Navigate to a project with `.gitea/workflows/`:
```bash
cd /path/to/project
```

2. List workflows:
```bash
act -l
```

3. Run a test:
```bash
act -j test
```

4. Before pushing to Gitea:
```bash
act  # Full test locally
git push
```

## For More Info

- act documentation: https://nektosact.com
- Podman documentation: https://podman.io/docs
- Gitea Actions: https://docs.gitea.com/usage/actions/overview

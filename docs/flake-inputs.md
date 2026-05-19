# Flake inputs

| Input | Source |
|---|---|
| `nixpkgs` | `nixos-unstable` |
| `home-manager` | `master` (follows nixpkgs) |
| `caelestia-shell` | `github:caelestia-dots/shell` |
| `caelestia-cli` | `github:caelestia-dots/cli` |
| `naviterm` | `gitlab:detoxify92/naviterm` |
| `solaar` | `https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz` |
| `cherri` | `github:electrikmilk/cherri` |

Notes:
- `home-manager` is pinned to `master` and follows `nixpkgs`.
- `solaar` is sourced from FlakeHub to track stable releases.

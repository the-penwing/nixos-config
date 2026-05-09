# Caps Lock layer (keyd)

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
| `Q` | Open launcher (Caelestia) |

## keyd universal remaps (main layer)

These work in any focused app, system-wide:

| Shortcut | Action |
|---|---|
| `Super + Z` | Undo (`Ctrl+Z`) |
| `Super + X` | Cut (`Ctrl+X`) |
| `Super + A` | Select all (`Ctrl+A`) |
| `Super + H / J / K / L` | Send `Super + ← / ↓ / ↑ / →` |

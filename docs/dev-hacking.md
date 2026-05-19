# Dev + hacking toolkit

This doc summarizes the daily development and ethical-hacking tooling available in this config.

## Source of truth

- System packages: `modules/system/packages.nix`
- User/dev shell packages: `modules/home/shell.nix`
- Task-specific shells: `flake.nix` (`devShells`)

## Development tooling

### Core languages and build toolchain
- Node.js
- Python 3 (pip + uv + pyenv)
- Rust (rustup)
- GCC + gnumake + pkg-config
- Lua tooling (lua, lua-language-server, luacheck, stylua)

### Dev workflow tools
- Git + Lazygit
- Neovim + Vim
- Docker (socket-activated)
- Arduino CLI + IDE
- Filezilla, lftp, samba clients (smbclient-ng)
- lazysql, sqlitebrowser
- tea (Gitea CLI)
- CLI utilities: ripgrep, fd, fzf, bat, eza, jq, tmux, glow, tldr

### Task-specific dev shells
- `nix develop .#default` (repo utilities)
- `nix develop .#pawn-appetit` (project-specific shell)
- `nix develop .#microbit-python`
- `nix develop .#microbit-rust`
- `nix develop .#microbit`
- `nix develop .#bash-scripting`

## Ethical-hacking lab tooling

### Lab/network baseline
- netcat, openvpn, openssl, inetutils, virt-manager, proxychains-ng, rlwrap

### Recon and enumeration
- nmap, rustscan
- feroxbuster, gobuster, ffuf, whatweb

### Web testing
- burpsuite, sqlmap, wpscan

### AD/internal network testing
- bloodhound-py, enum4linux-ng
- smbmap, smbclient-ng, impacket

### Traffic/tunneling analysis
- wireshark, tcpdump, chisel

### Exploitation and cracking
- metasploit
- hashcat, thc-hydra, jwt-cli

### Wordlists/helpers
- seclists

## Notes

- This suite is intended for authorized security testing, CTFs, and lab environments.
- If a package is renamed in nixpkgs, update `modules/system/packages.nix` first, then refresh this doc.

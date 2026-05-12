# Dev + hacking toolkit

This doc summarizes the daily development and ethical-hacking tooling available in this config.

## Source of truth

- System packages: `modules/system/packages.nix`
- User/dev shell packages: `modules/home/shell.nix`
- Task-specific shells: `flake.nix` (`devShells`)

## Development tooling

### Core languages and build toolchain
- Node.js
- Python 3
- Rust (rustup)
- GCC + make + pkg-config

### Dev workflow tools
- Git + Lazygit
- Neovim + Micro
- Docker (socket-activated)
- sqlitebrowser
- CLI utilities: ripgrep, fd, fzf, bat, eza, jq, tmux

### Task-specific dev shells
- `nix develop .#default`
- `nix develop .#pawn-appetit`
- `nix develop .#microbit-python`
- `nix develop .#microbit-rust`
- `nix develop .#microbit`
- `nix develop .#bash-scripting`

## Ethical-hacking lab tooling

### Lab/network baseline
- netcat, openvpn, inetutils, virt-manager, proxychains-ng, rlwrap

### Recon and enumeration
- nmap, rustscan, masscan
- amass, subfinder, dnsrecon
- nuclei, feroxbuster, gobuster, ffuf, whatweb, theharvester

### Web testing
- burpsuite, sqlmap, nikto, wpscan, wfuzz

### AD/internal network testing
- bloodhound-py, certipy, responder
- smbmap, enum4linux-ng, nbtscan, onesixtyone, snmpcheck
- netexec, impacket, evil-winrm, chisel

### Traffic/wireless analysis
- wireshark, tcpdump, bettercap, mitmproxy
- aircrack-ng, hcxdumptool, hcxtools

### Exploitation, cracking, and reverse engineering
- metasploit, exploitdb
- john, hashcat, hydra, jwt-cli
- yara, volatility3, ghidra, binwalk, radare2

### Wordlists/helpers
- seclists, assetfinder

## Notes

- This suite is intended for authorized security testing, CTFs, and lab environments.
- If a package is renamed in nixpkgs, update `modules/system/packages.nix` first, then refresh this doc.

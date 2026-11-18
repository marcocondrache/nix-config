# Nix configuration

[![Built with Nix](https://img.shields.io/badge/Built_With-Nix-5277C3.svg?logo=nixos&labelColor=73C3D5)](https://nixos.org)

This repository contains my personal system configurations using [Nix Flakes](https://nixos.wiki/wiki/Flakes). It manages my **Darwin** (macOS) machines through a modular, declarative approach with an emphasis on security and reproducibility.

## Overview

- [nix-darwin](https://github.com/nix-darwin/nix-darwin) configuration for my work MacBook (`xawed`)
- NixOS dev VM (`devbox`) running headless in UTM on the MacBook, reached over SSH
- [Determinate Nix](https://determinate.systems), configured through its nix-darwin module
- Encrypted secrets with [sops-nix](https://github.com/Mic92/sops-nix), decrypted on activation using a GPG key on **YubiKey**
- Modular `home-manager` configuration split into features
- Weekly cleanup of old generations through a `nh clean` launchd daemon

## Repository structure

```
nix-config
├── flake.nix         # Main flake configuration
├── home/             # Home-manager configurations
├── hosts/            # Host-specific configurations
├── lib/              # Custom Nix functions
└── modules/          # Custom home-manager modules
```

## Secrets management

Secrets are stored in `home/marcocondrache/secrets.yaml` and encrypted with the **GPG** key on the **YubiKey** (fingerprint in `.sops.yaml`). At activation time, the `sops-nix` launchd agent decrypts them to `~/.secrets/<key>`. Reference a secret from home-manager with `config.sops.secrets."<key>".path`, or load it into a shell via `set -gx VAR (cat ~/.secrets/<key>)`.

To edit secrets:
```bash
nix shell nixpkgs#sops --command sops home/marcocondrache/secrets.yaml
```

`git diff` shows secrets decrypted through the `sopsdiffer` driver configured in the git feature.

## Getting started

### Install Nix

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

### Quick start

```bash
# Clone and enter repository
git clone https://github.com/marcocondrache/nix-config.git && cd nix-config

# First activation, before nh is installed
sudo nix run nix-darwin -- switch --flake .#xawed

# Afterwards
nh darwin switch .#xawed
```

## NixOS VM

`devbox` is an aarch64 NixOS VM in [UTM](https://mac.getutm.app) (Apple Virtualization backend) where development happens; macOS keeps the GUI apps. The YubiKey stays on the Mac: the `devbox` ssh host entry forwards both the SSH agent and the gpg-agent extra socket, so `git push` and commit signing inside the VM still go through the YubiKey. The disk layout is declared with [disko](https://github.com/nix-community/disko) and installed with [nixos-anywhere](https://github.com/nix-community/nixos-anywhere).

### Bootstrap

1. Download the aarch64 minimal ISO from [nixos.org](https://nixos.org/download/#nixos-iso).
2. In UTM: **Create a New Virtual Machine → Virtualize → Linux**, tick **Use Apple Virtualization**, pick the ISO, give it 8 GB RAM, 6 cores and a 100 GB disk. Optionally add a shared directory; it is mounted at `/host`.
3. Boot it, then in the VM console set a temporary root password and note the IP:
   ```bash
   sudo passwd root
   ip -4 addr show
   ```
4. From the Mac, install (the build runs inside the VM):
   ```bash
   SSHPASS='<password>' nix run github:nix-community/nixos-anywhere -- \
     --env-password --build-on remote --flake .#devbox --target-host root@<ip>
   ```
5. Remove the ISO from the VM's drive in UTM and boot. Apply the Mac side once with `nh darwin switch .#xawed`, then `ssh devbox`.
6. Inside the VM, clone this repository to `~/Personal/nix-config`; from then on `nh os switch` rebuilds it.

To deploy uncommitted changes straight from the Mac (evaluated locally, built on the VM):
```bash
nh os switch -H devbox --target-host devbox --build-host devbox -e passwordless
```

The VM runs a personal [Rex](https://superlogical.com) server as a systemd user service. The Mac's `~/.config/rex/init.lua` declares it as the `devbox` host over `ssh://devbox`, so it shows up in the Rex app and `rex -S devbox ls` works. After the first switch on the Mac, run `rex config reload` to pick up the host.

## Contributing

This configuration is shared as a reference for the **Nix** community. You can:
- **Learn**: Use it as inspiration for your own setup
- **Improve**: Suggest improvements through issues
- **Share**: Help others in the Nix community
- **Contribute**: Submit pull requests for bug fixes

## License

This configuration is provided under the **MIT License**. You are free to use, modify, and distribute it as you see fit.

## Acknowledgments

- The **NixOS** community for creating an amazing system
- The **Nix Darwin** team for macOS support
- The **Home Manager** project for user environment management
- [Misterio77's nix-config](https://github.com/Misterio77/nix-config) for being the main inspiration for this configuration
- All the FOSS projects that make this configuration possible

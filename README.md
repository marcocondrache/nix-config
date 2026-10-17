# Nix configuration

[![Built with Nix](https://img.shields.io/badge/Built_With-Nix-5277C3.svg?logo=nixos&labelColor=73C3D5)](https://nixos.org)

This repository contains my personal system configurations using [Nix Flakes](https://nixos.wiki/wiki/Flakes). It manages my **Darwin** (macOS) machines through a modular, declarative approach with an emphasis on security and reproducibility.

## Overview

- [nix-darwin](https://github.com/nix-darwin/nix-darwin) configuration for my personal (`quemo`) and work (`xawed`) MacBooks
- [Determinate Nix](https://determinate.systems) on `xawed`, upstream Nix managed by nix-darwin on `quemo`
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
# xawed: Determinate Nix (the installer's default)
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# quemo: upstream Nix, managed by nix-darwin
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --prefer-upstream-nix
```

### Quick start

```bash
# Clone and enter repository
git clone https://github.com/marcocondrache/nix-config.git && cd nix-config

# First activation, before nh is installed
sudo nix run nix-darwin -- switch --flake .#hostname

# Afterwards
nh darwin switch .#hostname
```

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

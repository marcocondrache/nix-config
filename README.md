# Nix configuration

[![Built with Nix](https://img.shields.io/badge/Built_With-Nix-5277C3.svg?logo=nixos&labelColor=73C3D5)](https://nixos.org)

This repository contains my personal system configurations using [Nix Flakes](https://nixos.wiki/wiki/Flakes). It manages both **NixOS** and **Darwin** (macOS) systems through a modular, declarative approach with an emphasis on security and reproducibility.

## Overview

- Complete **NixOS** setup for desktop, laptop, and server machines
- **Darwin** configuration for personal and work MacBooks
- Stateless system design with **opt-in persistence**
- Secure mesh networking between all hosts
- Encrypted secrets using **GPG** and **SSH** keys
- Modular `home-manager` configuration with feature flags
- Single **BTRFS** partition with snapshot management
- Declarative configuration for all services

## Repository structure

```
nix-config
├── flake.nix         # Main flake configuration
├── home/             # Home-manager configurations
├── hosts/            # Host-specific configurations
├── lib/              # Custom Nix functions
├── modules/          # Custom NixOS/Darwin modules
└── scripts/          # Utility scripts
```

## Secrets management

Secrets are encrypted using both a **GPG** key (stored on **YubiKey**) and each host's **SSH** key, requiring only one of them to decrypt. This dual-key approach allows for both interactive editing using the YubiKey and automated decryption during system activation using the host's SSH key. The setup uses `sops-nix` to handle the encryption and decryption process transparently.

## System impermanence

This configuration embraces a stateless system design where the root filesystem is reset to a clean state on every boot. Through the `impermanence` module, specific directories can be marked for persistence - an opt-in approach to state management. The underlying **BTRFS** filesystem handles snapshots and rollbacks, providing both the benefits of a clean system and the safety of easy recovery.

## Getting started

### Darwin setup

```bash
# Install Nix
sh <(curl -L https://nixos.org/nix/install)

# Enable Flakes
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

### NixOS setup

```nix
# In your configuration.nix
{ pkgs, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
```

### Quick start

```bash
# Clone and enter repository
git clone https://github.com/marcocondrache/nix-config.git && cd nix-config

# Apply configuration
nix run nix-darwin -- switch --flake .#hostname     # For Darwin
sudo nixos-rebuild switch --flake .#hostname        # For NixOS
```

### System maintenance

```bash
# Update all packages
nix flake update

# Update specific input
nix flake lock --update-input nixpkgs

# Check system closure size
nix path-info -Sh /run/current-system
```

### Managing secrets

```bash
# Create or edit secrets
sops secrets/newsecret.yaml
sops secrets/existing.yaml

# Rotate keys
sops updatekeys secrets/secret.yaml
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
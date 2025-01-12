# Nix Configuration

This repository contains my personal system configuration using the Nix Flakes feature. It manages system configurations for multiple hosts (both NixOS and Darwin) and user environments through Home Manager.

## Structure

```
.
├── flake.nix            # Main flake configuration
├── home                 # Home-manager configurations
│   └── marcocondrache
│       ├── features     # Modular feature configurations
│       │   ├── cli      # Command-line tools and utilities
│       │   ├── desktop  # Desktop environment and applications
│       │   └── web      # Web development environment
└── hosts                # Host-specific configurations
    ├── common           # Shared configurations
    ├── quemo           # Configuration for Darwin host
    └── xawed           # Configuration for Darwin host
```

## Features

- **Cross-Platform Support**: Manages configurations for both Darwin and NixOS machines
- **Modular Design**: Organized into features for easy maintenance and reuse
- **Home Manager Integration**: User environment management using home-manager
- **Development Environment**: Configured for web development with modern tools
- **CLI Tools**: Various command-line utilities and configurations
- **Desktop Environment**: Complete desktop setup with common applications

## Usage

### Prerequisites

- For Darwin (macOS): 
  - Nix package manager installed
  - Nix Flakes enabled
- For NixOS:
  - NixOS installed
  - Flakes enabled in your Nix configuration

### Building and Applying Configuration

You can directly build and apply the configuration from the GitHub repository:

For Darwin hosts:
```bash
nix run nix-darwin -- switch --flake github:marcocondrache/nix-config#hostname
```

For NixOS hosts:
```bash
sudo nixos-rebuild switch --flake github:marcocondrache/nix-config#hostname
```
Replace `hostname` with your target host (e.g., quemo or xawed)

## License

This configuration is provided as-is. Feel free to use it as a reference for your own Nix setup. 
{ pkgs, ... }:
{
  imports = [
    ./direnv.nix
    ./bun.nix
    ./gh.nix
    ./git.nix
    ./gpg.nix
    ./fzf.nix
    ./btop.nix
    ./k9s.nix
    ./docker.nix
    ./lazygit.nix
    ./yubikey.nix
    ./fish.nix
    ./zellij.nix
    ./ssh.nix
  ];

  # General packages that don't need configuration
  home.packages = with pkgs; [
    # TODO: move
    biome

    kubectl
    hcloud
    speedtest-cli
    just

    eza

    nil
    nixfmt-rfc-style
  ];
}

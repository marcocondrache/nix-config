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
    ./yubikey.nix
    ./fish.nix
    ./ssh.nix
  ];

  # General packages that don't need configuration
  home.packages = with pkgs; [
    kubectl
    hcloud
    speedtest-cli
    just

    eza

    nil
    nixfmt-rfc-style
  ];
}

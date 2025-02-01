{ pkgs, ... }:
{
  imports = [
    ./gh.nix
    ./git.nix
    ./gpg.nix
    ./fzf.nix
    ./btop.nix
    ./k9s.nix
    ./docker.nix
    ./yubikey.nix
    # Package is broken
    #./ghostty.nix
    ./fish.nix
    ./ssh.nix
  ];

  # General packages that don't need configuration
  home.packages = with pkgs; [
    kubectl

    eza

    nil
    nixfmt-rfc-style
  ];
}

{ pkgs, ... }:
{
  imports = [
    ./gh.nix
    ./git.nix
    ./gpg.nix
    ./btop.nix
    ./k9s.nix
    ./docker.nix
    ./yubikey.nix
    # Package is broken
    #./ghostty.nix
    ./zsh.nix
  ];

  # General packages that don't need configuration
  home.packages = with pkgs; [
    colmena
    kubectl
  ];
}

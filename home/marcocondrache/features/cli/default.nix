{ pkgs, ... }:
{
  imports = [
    ./gh.nix
    ./git.nix
    ./gpg.nix
    ./htop.nix
    ./k9s.nix
    ./docker.nix
    # Package is broken
    #./ghostty.nix
    ./zsh.nix
  ];

  # General packages that don't need configuration
  home.packages = with pkgs; [
    colmena
  ];
}

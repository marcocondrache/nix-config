{ pkgs, ... }:
{
  imports = [
    ./gpg-agent.nix
    ./yubikey.nix
    ./zed.nix
  ];

  home.packages = [ pkgs.mole-cleaner ];
}

{ pkgs, ... }:
{
  imports = [
    ./fonts.nix
    ./gpg-agent.nix
    ./yubikey.nix
    ./zed.nix
  ];

  home.packages = [ pkgs.mole-cleaner ];
}

{ pkgs, ... }:
{
  imports = [
    ./fonts.nix
    ./gpg-agent.nix
    ./sops.nix
    ./yubikey.nix
    ./zed.nix
  ];

  home.packages = [ pkgs.mole-cleaner ];
}

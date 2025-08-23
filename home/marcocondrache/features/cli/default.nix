{ pkgs, ... }:
{
  imports = [
    ./direnv.nix
    ./bun.nix
    ./gh.nix
    ./git.nix
    ./gpg.nix
    ./fzf.nix
    ./atuin.nix
    ./btop.nix
    ./k9s.nix
    ./kubef.nix
    ./docker.nix
    ./lazygit.nix
    ./yubikey.nix
    ./fish.nix
    ./zoxide.nix
    ./ssh.nix
  ];

  # General packages that don't need configuration
  home.packages = with pkgs; [
    eza
    devbox
    gnumake

    nil
    nixfmt-rfc-style
  ];
}

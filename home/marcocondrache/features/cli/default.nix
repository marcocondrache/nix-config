{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./atuin.nix
    ./bun.nix
    ./difftastic.nix
    ./direnv.nix
    ./docker.nix
    ./fish.nix
    ./fonts.nix
    ./fzf.nix
    ./gh.nix
    ./git.nix
    ./gpg.nix
    ./k9s.nix
    ./kubef.nix
    ./mergiraf.nix
    ./ssh.nix
    ./yubikey.nix
    ./zoxide.nix
  ];

  # General packages that don't need configuration
  home.packages = with pkgs; [
    eza
    devenv
    gnumake
    ripgrep
    curlFull
    tailspin

    nil
    nixd
    nixfmt
  ];
}

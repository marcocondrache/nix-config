{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./atuin.nix
    ./docker.nix
    ./fish
    ./fonts.nix
    ./fzf.nix
    ./gh.nix
    ./git.nix
    ./gpg.nix
    ./mergiraf.nix
    ./mise.nix
    ./nh.nix
    ./skills.nix
    ./sops.nix
    ./sofka.nix
    ./ssh.nix
    ./yubikey.nix
    ./zoxide.nix
    ./zed.nix
  ];

  # General packages that don't need configuration
  home.packages = with pkgs; [
    eza
    gnumake
    ripgrep
    curlFull
    tailspin
    mole-cleaner
    coreutils

    jq
    fd
    yq-go

    nil
    nixd
    nixfmt
  ];
}

{ pkgs, ... }:
{
  imports = [
    ./atuin.nix
    ./fish
    ./fzf.nix
    ./gh.nix
    ./git.nix
    ./gpg.nix
    ./mergiraf.nix
    ./mise.nix
    ./nh.nix
    ./rex.nix
    ./sops.nix
    ./ssh.nix
    ./xdg.nix
    ./zoxide.nix
  ];

  # General packages that don't need configuration
  home.packages = with pkgs; [
    eza
    gnumake
    ripgrep
    curlFull
    tailspin
    coreutils

    jq
    fd
    yq-go

    nixd
    nixfmt
  ];
}

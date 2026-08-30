{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./atuin.nix
    ./bun.nix
    ./difftastic.nix
    ./direnv.nix
    ./devenv.nix
    ./docker.nix
    ./fish
    ./fonts.nix
    ./fzf.nix
    ./gh.nix
    ./git.nix
    ./gpg.nix
    ./k9s.nix
    ./kubef.nix
    ./mergiraf.nix
    ./nh.nix
    ./opencode.nix
    ./sops.nix
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
    speedtest-cli
    coreutils

    jq
    fd
    yq-go

    nil
    nixd
    nixfmt
  ];
}

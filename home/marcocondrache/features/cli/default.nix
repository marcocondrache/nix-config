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
    # ./mcfly.nix
    ./btop.nix
    # ./fonts.nix
    ./ghostty.nix
    ./alacritty.nix
    ./k9s.nix
    ./kubef.nix
    ./docker.nix
    ./yazi.nix
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
    devenv
    gnumake
    ripgrep
    curlFull
    tailspin

    nil
    nixd
    nixfmt-rfc-style
  ];
}

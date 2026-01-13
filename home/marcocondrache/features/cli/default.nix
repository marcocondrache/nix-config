{ pkgs, ... }:
{
  imports = [
    ./direnv.nix
    ./bun.nix
    ./gh.nix
    ./git.nix
    ./mergiraf.nix
    ./gpg.nix
    ./fzf.nix
    ./atuin.nix
    ./difftastic.nix
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

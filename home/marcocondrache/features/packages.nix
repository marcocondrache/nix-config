{ pkgs, ... }:
{
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

    git-absorb
  ];
}

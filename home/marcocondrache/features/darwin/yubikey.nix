{ pkgs, ... }:
{
  home.packages = with pkgs; [
    yubikey-manager
    libfido2
  ];
}

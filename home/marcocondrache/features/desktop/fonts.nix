{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hack-font
  ];

  fonts.fontconfig.enable = true;
}

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    darwin.xcode
  ];
}

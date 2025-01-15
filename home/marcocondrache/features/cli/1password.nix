{ pkgs, lib, ... }:
{
  programs._1password-shell-plugins = {
    enable = lib.mkDefault true;
    plugins =
      with pkgs;
      lib.mkDefault [
        gh
      ];
  };
}

{ lib, ... }:
{
  programs.sofka = {
    enable = lib.mkDefault true;
  };
}

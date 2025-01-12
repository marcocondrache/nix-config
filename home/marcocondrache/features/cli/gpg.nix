{ lib, ... }:
{
  programs.gpg = {
    enable = lib.mkDefault true;
    publicKeys = [
      {
        source = ../../pgp.asc;
        trust = 5;
      }
    ];
  };
}

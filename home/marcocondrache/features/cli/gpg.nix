{ lib, ... }:
let
  _gpg-autostart = ''
    gpgconf --launch gpg-agent
  '';
in
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

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;

    maxCacheTtl = 120;
    defaultCacheTtl = 60;
  };
}

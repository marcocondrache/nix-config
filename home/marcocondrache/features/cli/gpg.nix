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
    sshKeys = [ "8A4248ED29B2E49BEA8D6D2560CD3EBBEADCE11D" ];

    maxCacheTtl = 120;
    defaultCacheTtl = 60;
  };
}

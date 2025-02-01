{ lib, ... }:
let
  gpg-autostart = ''
    gpgconf --launch gpg-agent
  '';
in
{
  programs.fish.loginShellInit = gpg-autostart;

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

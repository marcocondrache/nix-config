{
  lib,
  pkgs,
  ...
}:
{
  programs.gpg = {
    enable = lib.mkDefault true;
    publicKeys = [
      {
        source = ../pgp.asc;
        trust = 5;
      }
    ];
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableExtraSocket = true;
    pinentry.package = pkgs.pinentry_mac;
    sshKeys = [ "8A4248ED29B2E49BEA8D6D2560CD3EBBEADCE11D" ];

    defaultCacheTtl = 28800;
    defaultCacheTtlSsh = 28800;
    maxCacheTtl = 86400;
    maxCacheTtlSsh = 86400;
  };
}

{
  lib,
  hosts,
  ...
}:
{
  services.openssh = {
    enable = lib.mkDefault true;
  };

  programs.ssh = {
    knownHosts = lib.genAttrs hosts (hostname: {
      publicKeyFile = ../../${hostname}/ssh_ed25519.pub;
      hostNames = [ "${hostname}.marcocondrache.com" ];
    });
  };
}

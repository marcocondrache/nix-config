{
  lib,
  hosts,
  ...
}:
{
  services.openssh = {
    enable = lib.mkDefault true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";

      StreamLocalBindUnlink = "yes";
    };

    hostKeys = [
      {
        path = "/persist/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  # programs.ssh = {
  #   knownHosts = lib.genAttrs hosts (hostname: {
  #     publicKeyFile = ../../${hostname}/ssh_host_ed25519_key.pub;
  #     hostNames = [ "${hostname}.marcocondrache.com" ];
  #   });
  # };

  security.pam.sshAgentAuth = {
    enable = true;
    authorizedKeysFiles = [ "/etc/ssh/authorized_keys.d/%u" ];
  };
}

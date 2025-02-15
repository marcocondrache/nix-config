{
  lib,
  ...
}:
{
  services.openssh = {
    enable = lib.mkDefault true;

    settings = {
      StreamLocalBindUnlink = "yes";
      PermitRootLogin = "no";
      GatewayPorts = "clientspecified";
    };

    hostKeys = [
      {
        path = "/persist/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };
}

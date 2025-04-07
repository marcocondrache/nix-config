{
  lib,
  ...
}:
{
  services.openssh = {
    enable = lib.mkDefault true;

    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";

      StreamLocalBindUnlink = "yes";
      GatewayPorts = "clientspecified";
    };
  };

  security.pam.sshAgentAuth = {
    enable = true;
  };
}

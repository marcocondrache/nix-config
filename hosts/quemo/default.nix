{
  host,
  user,
  ...
}:
{
  imports = [
    ../common/global
    ../common/users/${user}
  ];

  networking = {
    hostName = host;
    computerName = host;
    localHostName = host;
  };

  security.pam.enableSudoTouchIdAuth = true;

  system.stateVersion = 5;
}

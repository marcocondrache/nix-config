{
  host,
  ...
}:
{
  networking = {
    hostName = host;
    computerName = host;
    localHostName = host;
  };

  security.pam.enableSudoTouchIdAuth = true;
}

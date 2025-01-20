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

  system = {
    stateVersion = 5;
  };

  security.pam.enableSudoTouchIdAuth = true;

  users.users.marcocondrache = {
    name = "marcocondrache";
    home = "/Users/marcocondrache";
  };
}

{
  self,
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
    configurationRevision = self.rev or self.dirtyRev or null;
  };

  security.pam.enableSudoTouchIdAuth = true;
}

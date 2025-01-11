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

  system = {
    stateVersion = 5;

    dock = {
      autohide = true;
      orientation = "bottom";
      magnification = false;
      mineffect = "genie";
      minimize-to-application = false;
      show-recents = false;
    };
  };

  security.pam.enableSudoTouchIdAuth = true;

}

{
  lib,
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

  homebrew = {
    enable = lib.mkDefault true;

    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
    };

    global = {
      autoUpdate = false;
    };
  };

  security.pam.enableSudoTouchIdAuth = true;

  users.users.marcocondrache = {
    name = "marcocondrache";
    home = "/Users/marcocondrache";
  };
}

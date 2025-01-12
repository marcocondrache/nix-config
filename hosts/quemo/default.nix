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

    defaults = {
      dock = {
        autohide = true;
        orientation = "bottom";
        magnification = false;
        mineffect = "genie";
        minimize-to-application = false;
        show-recents = false;
      };

      finder = {
        CreateDesktop = false;
        AppleShowAllExtensions = true;
        FXPreferredViewStyle = "Nlsv";
        FXEnableExtensionChangeWarning = false;
      };

      controlcenter = {
        BatteryShowPercentage = true;
      };

      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
    };
  };

  security.pam.enableSudoTouchIdAuth = true;
}

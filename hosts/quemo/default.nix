{
  user,
  ...
}:
{
  imports = [
    ../common/global
    ../common/users/${user}

    ../common/optional/darwin.nix
  ];

  system = {
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

}

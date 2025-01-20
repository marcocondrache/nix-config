{
  ...
}:
{
  imports = [
    ../common/global
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
        NewWindowTarget = "Home";
      };

      NSGlobalDomain = {
        KeyRepeat = 1;
        InitialKeyRepeat = 15;

        AppleKeyboardUIMode = 3;
        AppleInterfaceStyle = "Dark";

        NSDocumentSaveNewDocumentsToCloud = false;
      };

      WindowManager = {
        EnableStandardClickToShowDesktop = false;
      };

      screencapture = {
        # Save screenshots to clipboard instead of the default location
        target = "clipboard";
      };

      controlcenter = {
        BatteryShowPercentage = true;
      };

      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
    };
  };
}

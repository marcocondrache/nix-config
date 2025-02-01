{
  ...
}:
{
  imports = [
    ../common/global
    ../common/optional/darwin-homebrew.nix
    ../common/optional/darwin-ios-sdk.nix
    ../common/users/marcocondrache
  ];

  users.users.marcocondrache.home = "/Users/marcocondrache";

  security.pam.enableSudoTouchIdAuth = true;

  system = {
    stateVersion = 6;

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

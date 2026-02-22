{
  host,
  ...
}:
{
  imports = [
    ../common/global
    ../common/optional/determinate.nix
    ../common/users/marcocondrache/darwin.nix
  ];

  security.pam.services.sudo_local.touchIdAuth = true;

  networking = {
    computerName = host;
    localHostName = host;
  };

  system = {
    stateVersion = 6;

    defaults = {
      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.2;
        orientation = "right";
        magnification = false;
        mineffect = "genie";
        mru-spaces = false;
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
        InitialKeyRepeat = 10;

        ApplePressAndHoldEnabled = false;
        AppleKeyboardUIMode = 3;
        AppleInterfaceStyle = "Dark";

        NSDocumentSaveNewDocumentsToCloud = false;
      };

      WindowManager = {
        EnableStandardClickToShowDesktop = false;
      };

      screencapture = {
        target = "clipboard";
      };

      controlcenter = {
        BatteryShowPercentage = true;
      };

      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
    };
  };
}

{
  host,
  ...
}:
{
  imports = [
    ../common/global
    ../common/users/marcocondrache/darwin.nix
    ../common/optional/darwin-builder.nix
  ];

  nix.linux-builder = {
    maxJobs = 4;
    ephemeral = true;
    config = {
      virtualisation = {
        darwin-builder = {
          diskSize = 40 * 1024;
          memorySize = 8 * 1024;
        };

        cores = 6;
      };
    };
  };

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
        target = "clipboard";
      };

      controlcenter = {
        BatteryShowPercentage = true;
      };

      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
    };
  };
}

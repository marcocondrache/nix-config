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

  security.pam.services.sudo_local = {
    touchIdAuth = true;
    watchIdAuth = true;
  };

  networking = {
    computerName = host;
    localHostName = host;
  };

  system = {
    stateVersion = 6;

    startup.chime = false;

    keyboard = {
      enableKeyMapping = false;
    };

    defaults = {
      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.2;
        orientation = "right";
        magnification = false;
        mineffect = "genie";
        mru-spaces = false;
        expose-animation-duration = 0.1;
        minimize-to-application = false;
        show-recents = false;
        show-process-indicators = true;
      };

      finder = {
        CreateDesktop = false;
        AppleShowAllExtensions = true;
        FXPreferredViewStyle = "Nlsv";
        FXEnableExtensionChangeWarning = false;
        NewWindowTarget = "Home";
        ShowPathbar = true;
        ShowStatusBar = true;
        _FXSortFoldersFirst = true;
        _FXShowPosixPathInTitle = true;
      };

      NSGlobalDomain = {
        KeyRepeat = 1;
        InitialKeyRepeat = 14;

        ApplePressAndHoldEnabled = false;
        AppleKeyboardUIMode = 3;
        AppleInterfaceStyle = "Dark";

        NSDocumentSaveNewDocumentsToCloud = false;

        # Stop macOS from "helpfully" rewriting code and text
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;

        # Snappier window animations
        NSWindowResizeTime = 0.001;
        NSAutomaticWindowAnimationsEnabled = false;
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };

      loginwindow = {
        GuestEnabled = false;
      };

      menuExtraClock = {
        Show24Hour = true;
        ShowSeconds = false;
      };

      WindowManager = {
        EnableStandardClickToShowDesktop = false;
      };

      universalaccess = {
        reduceMotion = true;
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

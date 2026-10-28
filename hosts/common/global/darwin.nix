{ host, ... }:
{
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    watchIdAuth = true;
    reattach = true;
  };

  networking = {
    computerName = host;
    localHostName = host;
  };

  system = {
    stateVersion = 6;

    startup.chime = false;

    defaults = {
      dock = {
        autohide = true;
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

      NSGlobalDomain = {
        KeyRepeat = 1;

        ApplePressAndHoldEnabled = false;
        AppleKeyboardUIMode = 3;
        AppleInterfaceStyle = "Dark";

        # Stop macOS from "helpfully" rewriting code and text
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
      };

      controlcenter = {
        BatteryShowPercentage = true;
      };

      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;

      CustomUserPreferences = {
        "com.apple.assistant.support"."Assistant Enabled" = false;
        "com.apple.Siri" = {
          StatusMenuVisible = false;
          UserHasDeclinedEnable = true;
          VoiceTriggerUserEnabled = false;
        };
      };
    };
  };
}

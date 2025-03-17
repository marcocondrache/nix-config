{
  host,
  ...
}:
{
  imports = [
    ../common/global
    ../common/users/marcocondrache/darwin.nix
    ../common/optional/darwin-homebrew.nix
    ../common/optional/darwin-tailscale.nix
  ];

  users.users.marcocondrache.home = "/Users/marcocondrache";

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
      };

      NSGlobalDomain = {
        KeyRepeat = 1;
        InitialKeyRepeat = 15;

        AppleKeyboardUIMode = 3;
        AppleInterfaceStyle = "Dark";
      };

      controlcenter = {
        BatteryShowPercentage = true;
      };

      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
    };
  };

}

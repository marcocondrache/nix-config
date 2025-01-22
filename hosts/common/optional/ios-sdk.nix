{
  pkgs,
  ...
}:
{
  # System tools for iOS development

  environment.systemPackages = with pkgs; [
    cocoapods
  ];

  homebrew = {
    masApps = {
      Xcode = 497799835;
    };
  };
}

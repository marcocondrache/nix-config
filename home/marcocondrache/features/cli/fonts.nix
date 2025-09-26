{ pkgs, ... }:
{
  home.fontProfiles = {
    enable = true;
    fonts = [
      {
        name = "Hack";
        package = pkgs.hack-font;
      }
    ];
  };
}

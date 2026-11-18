{ pkgs, ... }:
{
  home.fontProfiles = {
    enable = true;
    fonts = [
      {
        name = "CommitMono";
        package = pkgs.commit-mono;
      }
    ];
  };
}

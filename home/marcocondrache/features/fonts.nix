{ pkgs, ... }:
{
  home.fontProfiles = {
    enable = true;
    fonts = [
      {
        name = "CommitMono";
        package = pkgs.commit-mono;
      }
      {
        name = "CommitMono Nerd Font";
        package = pkgs.nerd-fonts.commit-mono;
      }
    ];
  };
}

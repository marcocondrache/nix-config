{
  lib,
  ...
}:
{
  home = {
    username = "marcocondrache";
    stateVersion = lib.mkDefault "25.05";
    enableNixpkgsReleaseCheck = false;
  };

  programs = {
    home-manager.enable = true;
  };
}

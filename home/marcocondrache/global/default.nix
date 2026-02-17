{
  lib,
  ...
}:
{
  home = {
    username = "marcocondrache";
    stateVersion = lib.mkDefault "25.05";
  };

  programs = {
    home-manager.enable = true;
  };
}

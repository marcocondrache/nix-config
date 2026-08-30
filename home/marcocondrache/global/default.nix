{
  lib,
  ...
}:
{
  home = {
    username = "marcocondrache";
    stateVersion = lib.mkDefault "25.05";
    enableNixpkgsReleaseCheck = false;

    # Disable the login message
    file.".hushlogin".text = "";
  };

  programs = {
    home-manager.enable = true;
  };
}

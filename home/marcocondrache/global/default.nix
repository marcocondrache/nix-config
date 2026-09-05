{
  lib,
  ...
}:
{
  home = {
    username = "marcocondrache";
    stateVersion = lib.mkDefault "26.05";
    enableNixpkgsReleaseCheck = false;

    # Disable the login message
    file.".hushlogin".text = "";
  };

  programs = {
    home-manager.enable = true;
  };
}

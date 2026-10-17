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

  # Building the options manpage costs ~10% of eval time
  manual.manpages.enable = false;

  programs = {
    home-manager.enable = true;
  };
}

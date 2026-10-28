{
  lib,
  inputs,
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

  # Keep nixpkgs#… on the locked revision instead of the global registry
  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  # Building the options manpage costs ~10% of eval time
  manual.manpages.enable = false;

  programs = {
    home-manager.enable = true;
  };
}

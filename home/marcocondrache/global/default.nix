{
  lib,
  config,
  inputs,
  ...
}:
{
  home = {
    username = "marcocondrache";
    stateVersion = lib.mkDefault "26.05";
    enableNixpkgsReleaseCheck = false;

    # Where standalone installers (mise, uv, ...) drop binaries
    sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];

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

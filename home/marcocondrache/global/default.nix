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

    sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];

    file.".hushlogin".text = "";
  };

  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  manual.manpages.enable = false;

  programs = {
    home-manager.enable = true;
  };
}

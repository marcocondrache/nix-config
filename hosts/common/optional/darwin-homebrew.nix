{
  lib,
  inputs,
  ...
}:
{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  # Installation of homebrew
  nix-homebrew = {
    # TODO: make this dynamic
    user = "marcocondrache";

    taps = {
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
    };

    enable = true;
    autoMigrate = true;
    mutableTaps = false;
  };

  # Configuration through nix-darwin
  homebrew = {
    enable = lib.mkDefault true;

    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
    };

    global = {
      autoUpdate = false;
    };
  };
}

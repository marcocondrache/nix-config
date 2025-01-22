{
  lib,
  inputs,
  settings,
  ...
}:
{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  # Installation of homebrew
  nix-homebrew = {
    inherit (settings) user;

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

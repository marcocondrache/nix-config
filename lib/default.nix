{
  inputs,
  ...
}:
{
  mkDarwinConfig =
    {
      host,
      system ? "aarch64-darwin",
    }:
    inputs.nix-darwin.lib.darwinSystem {
      inherit system;

      specialArgs = {
        inherit host;
        inherit inputs;
      };

      modules = [
        inputs.home-manager.darwinModules.home-manager
        (../hosts + "/${host}")
      ];
    };
}

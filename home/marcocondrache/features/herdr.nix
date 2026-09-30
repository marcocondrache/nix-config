{ inputs, pkgs, ... }:
{
  programs.herdr = {
    enable = true;
    package = inputs.herdr.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
}

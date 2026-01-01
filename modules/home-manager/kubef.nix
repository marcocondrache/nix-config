{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.kubef;

  inherit (lib) mkIf;
in
{
  options.programs.kubef = {
    enable = lib.mkEnableOption "kubef";

    package = lib.mkPackageOption inputs.kubef.packages.${pkgs.stdenv.hostPlatform.system} "kubef" { };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}

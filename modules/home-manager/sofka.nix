{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.sofka;

  inherit (lib) mkIf;
in
{
  options.programs.sofka = {
    enable = lib.mkEnableOption "sofka";

    package = lib.mkPackageOption inputs.sofka.packages.${pkgs.stdenv.hostPlatform.system} "sofka" { };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}

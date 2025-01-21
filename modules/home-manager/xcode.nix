{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.programs.xcode;
in
{
  options.programs.xcode = {
    enable = lib.mkEnableOption "Xcode";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.xcode
    ];
  };
}

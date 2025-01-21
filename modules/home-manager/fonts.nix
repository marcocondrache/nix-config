{
  lib,
  config,
  ...
}:
let
  mkFontOption = lib.types.submodule {
    options = {
      name = lib.mkOption {
        type = lib.types.str;
        description = "Family name for font profile";
        example = "Fira Code";
      };
      package = lib.mkOption {
        type = lib.types.package;
        description = "Package for font profile";
        example = "pkgs.fira-code";
      };
    };
  };
in
{
  options.home.fontProfiles = {
    enable = lib.mkEnableOption "Whether to enable font profiles";
    fonts = lib.mkOption {
      type = lib.types.listOf mkFontOption;
      default = [ ];
      description = "List of font profiles";
      example = ''
        [
          {
            name = "Fira Code";
            package = pkgs.fira-code;
          }
        ]'';
    };
  };

  config = lib.mkIf config.home.fontProfiles.enable {
    fonts.fontconfig.enable = true;
    home.packages = map (font: font.package) config.home.fontProfiles.fonts;
  };
}

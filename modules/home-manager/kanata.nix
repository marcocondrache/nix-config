{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.services.kanata;

  inherit (lib) mkIf mkEnableOption mkOption types;
in
{
  options.services.kanata = {
    enable = mkEnableOption "kanata user agent";

    package = lib.mkPackageOption pkgs "kanata-with-cmd" { };

    configFile = mkOption {
      type = types.path;
      default = "${config.home.homeDirectory}/.config/kanata/kanata.kbd";
      description = "Path to kanata configuration file";
    };

    config = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Kanata configuration content. If set, written to configFile via home.file.";
    };

    extraArgs = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Extra CLI arguments for kanata";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    home.file.".config/kanata/kanata.kbd" = mkIf (cfg.config != null) {
      text = cfg.config;
    };

    # Stable wrapper at a fixed path so macOS Input Monitoring permission
    # survives nix rebuilds (the nix store path changes each time).
    home.file.".local/bin/kanata" = {
      executable = true;
      text = ''
        #!/bin/bash
        exec ${lib.getExe cfg.package} "$@"
      '';
    };

    launchd.agents.kanata = {
      enable = true;
      config = {
        Label = "org.kanata.daemon";
        ProgramArguments =
          [
            "/usr/bin/sudo"
            "${config.home.homeDirectory}/.local/bin/kanata"
            "--cfg"
            (toString cfg.configFile)
            "--nodelay"
          ]
          ++ cfg.extraArgs;
        RunAtLoad = true;
        KeepAlive = true;
        StandardOutPath = "/tmp/kanata.log";
        StandardErrorPath = "/tmp/kanata.err";
      };
    };
  };
}

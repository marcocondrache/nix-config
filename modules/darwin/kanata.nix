{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.services.kanata;

  inherit (lib)
    mkIf
    mkEnableOption
    mkOption
    types
    ;
in
{
  options.services.kanata = {
    enable = mkEnableOption "kanata system prerequisites";

    package = lib.mkPackageOption pkgs "kanata-with-cmd" { };

    user = mkOption {
      type = types.str;
      default = "marcocondrache";
      description = "Username for sudoers entry and paths";
    };

    sudoers = mkOption {
      type = types.bool;
      default = true;
      description = "Add NOPASSWD sudoers entry for kanata binary";
    };

    karabiner.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Install and activate Karabiner DriverKit VirtualHIDDevice";
    };
  };

  config =
    let
      karabinerDaemon = "/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon";
      karabinerManager = "/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager";
    in
    mkIf cfg.enable {
      environment.etc."sudoers.d/kanata".text = mkIf cfg.sudoers ''
        ${cfg.user} ALL=(root) NOPASSWD: ${lib.getExe cfg.package}
        ${cfg.user} ALL=(root) NOPASSWD: /Users/${cfg.user}/.local/bin/kanata
      '';

      launchd.daemons."org.pqrs.Karabiner-VirtualHIDDevice-Daemon" = mkIf cfg.karabiner.enable {
        serviceConfig = {
          Label = "org.pqrs.Karabiner-VirtualHIDDevice-Daemon";
          ProgramArguments = [ karabinerDaemon ];
          RunAtLoad = true;
          KeepAlive = true;
        };
      };

      system.activationScripts.preActivation.text = ''
        echo "stopping kanata..." >&2
        pkill -x kanata || true
      '';

      system.activationScripts.postActivation.text = mkIf cfg.karabiner.enable ''
        KARABINER_VERSION="6.10.0"
        KARABINER_PKG="Karabiner-DriverKit-VirtualHIDDevice-$KARABINER_VERSION.pkg"
        KARABINER_URL="https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/releases/download/v$KARABINER_VERSION/$KARABINER_PKG"
        KARABINER_MANAGER="${karabinerManager}"

        if [ ! -f "$KARABINER_MANAGER" ]; then
          echo "installing Karabiner DriverKit VirtualHIDDevice v$KARABINER_VERSION..." >&2
          KARABINER_TMP=$(mktemp -d)
          curl -sL "$KARABINER_URL" -o "$KARABINER_TMP/$KARABINER_PKG"
          installer -pkg "$KARABINER_TMP/$KARABINER_PKG" -target /
          rm -rf "$KARABINER_TMP"
        fi

        echo "activating Karabiner DriverKit VirtualHIDDevice..." >&2
        "$KARABINER_MANAGER" activate
      '';
    };
}

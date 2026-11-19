{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.determinate.darwinModules.default ];

  determinateNix = {
    enable = true;
    determinateNixd.telemetry.sentry.endpoint = null;
    # nix.settings is ignored when Determinate manages nix
    customSettings = import ../global/nix-settings.nix;
  };

  launchd.daemons.nh-clean = {
    command = "${lib.getExe pkgs.nh} clean all --keep 10 --keep-since 14d";
    path = [
      "/nix/var/nix/profiles/default/bin"
      "/run/current-system/sw/bin"
      "/usr/bin"
      "/bin"
    ];
    serviceConfig = {
      RunAtLoad = false;
      StartCalendarInterval = [
        {
          Weekday = 1;
          Hour = 12;
          Minute = 0;
        }
      ];
      StandardOutPath = "/var/log/nh-clean.log";
      StandardErrorPath = "/var/log/nh-clean.log";
    };
  };
}

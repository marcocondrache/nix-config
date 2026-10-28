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
    customSettings = {
      eval-cores = 0;
      warn-dirty = false;
      download-buffer-size = 134217728;
      http-connections = 64;
      extra-substituters = [ "https://nkl-sofka.cachix.org" ];
      extra-trusted-public-keys = [
        "nkl-sofka.cachix.org-1:hLg9frFNJynrxe7SSBb/p6pbawlpZmG10bw+wLsTufw="
      ];
      trusted-users = [ "marcocondrache" ];
    };
  };

  # Store GC alone can't reclaim paths still rooted by old generations
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

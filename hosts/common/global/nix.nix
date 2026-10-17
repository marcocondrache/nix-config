{ lib, pkgs, ... }:
{
  nix = {
    settings = {
      warn-dirty = false;
      download-buffer-size = 134217728;
      http-connections = 64;

      experimental-features = [
        "nix-command"
        "flakes"
      ];

      trusted-users = [
        "@wheel"
        "@admin"
      ];
    };

    channel = {
      enable = false;
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

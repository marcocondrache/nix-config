{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.determinate.nixosModules.default ];

  nix.settings = lib.mkMerge [
    (import ../global/nix-settings.nix)
    {
      # Determinate Nix isn't on cache.nixos.org. nixos-anywhere copies only these
      # two settings (not the extra- variants) into the installer
      substituters = [ "https://install.determinate.systems" ];
      trusted-public-keys = [
        "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
        "cache.flakehub.com-4:Asi8qIv291s0aYLyH6IOnr5Kf6+OF14WVjkE6t3xMio="
        "cache.flakehub.com-5:zB96CRlL7tiPtzA9/WKyPkp3A2vqxqgdgyTVNGShPDU="
        "cache.flakehub.com-6:W4EGFwAGgBj3he7c5fNh9NkOXw0PUVaxygCVKeuvaqU="
        "cache.flakehub.com-7:mvxJ2DZVHn/kRxlIaxYNMuDG1OvMckZu32um1TadOR8="
        "cache.flakehub.com-8:moO+OVS0mnTjBTcOUh2kYLQEd59ExzyoW1QgQ8XAARQ="
        "cache.flakehub.com-9:wChaSeTI6TeCuV/Sg2513ZIM9i0qJaYsF+lZCXg0J6o="
        "cache.flakehub.com-10:2GqeNlIp6AKp4EF2MVbE1kBOp9iBSyo0UPR9KoR0o1Y="
      ];
    }
  ];

  # The NixOS module has no option for this, unlike determinateNixd.telemetry on darwin
  environment.etc."determinate/config.json".text = builtins.toJSON {
    telemetry.sentry.endpoint = null;
  };

  # `nh os switch --target-host` from the Mac snapshots the remote generation with dix
  environment.systemPackages = [ pkgs.dix ];

  programs.nh.clean = {
    enable = true;
    dates = "weekly";
    extraArgs = "--keep 10 --keep-since 14d";
  };
}

{ pkgs, settings, ... }:
{
  system.stateVersion = 5;

  # nix
  services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  environment.systemPackages = with pkgs; [
    nil
    nixfmt-rfc-style
  ];

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "raycast"
    ];

  users.users.${settings.username} = {
    name = settings.username;
    home = "/Users/${settings.username}";
  };
}

{
  pkgs,
  username,
  ...
}:
{
  system.stateVersion = 5;

  # nix
  services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  environment.systemPackages = with pkgs; [
    nil
    nixfmt-rfc-style
  ];

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };
}

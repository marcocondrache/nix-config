{
  lib,
  user,
  ...
}:
{
  imports = [
    ./features/cli
  ];

  home = {
    username = user;
    stateVersion = lib.mkDefault "24.11";
  };

  programs = {
    home-manager.enable = true;
  };
}

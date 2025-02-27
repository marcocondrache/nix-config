{
  nix = {
    linux-builder = {
      enable = true;
      ephemeral = true;
    };

    settings.trusted-users = [ "@admin" ];
  };
}

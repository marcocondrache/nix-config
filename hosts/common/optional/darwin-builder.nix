{
  nix = {
    linux-builder = {
      enable = true;
    };

    settings.trusted-users = [ "@admin" ];
  };
}

{
  nix = {
    settings = {
      warn-dirty = false;

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
}

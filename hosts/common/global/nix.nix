{
  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    gc = {
      automatic = true;
    };
  };
}

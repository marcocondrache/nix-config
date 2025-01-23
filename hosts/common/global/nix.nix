{
  nix = {
    settings = {
      warn-dirty = false;

      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    optimise = {
      automatic = true;
    };

    gc = {
      automatic = true;

      # Keep last 3 generations
      options = "--delete-older-than +3";
    };

    channel = {
      enable = false;
    };
  };
}

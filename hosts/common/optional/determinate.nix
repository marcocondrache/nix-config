{
  nix.enable = false;

  determinateNix = {
    enable = true;
    customSettings = {
      eval-cores = 0;
    };
  };
}

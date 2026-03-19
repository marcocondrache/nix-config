{
  lib,
  ...
}:
{
  programs.k9s = {
    enable = lib.mkDefault true;
    settings = {
      k9s = {
        liveViewAutoRefresh = true;
        refreshRate = 1;
        ui = {
          headless = true;
        };
      };
    };
  };
}

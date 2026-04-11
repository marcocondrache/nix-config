{
  lib,
  ...
}:
{
  programs.k9s = {
    enable = lib.mkDefault true;
    settings = {
      k9s = {
        refreshRate = 2;
        ui = {
          enableMouse = false;
          splashless = true;
          headless = true;
        };
      };
    };
  };
}

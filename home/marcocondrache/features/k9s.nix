{
  lib,
  pkgs,
  ...
}:
{
  home.packages = [ pkgs.stern ];

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

    plugins = {
      stern = {
        shortCut = "Ctrl-Y";
        confirm = false;
        description = "Logs <Stern>";
        scopes = [ "pods" ];
        command = "stern";
        background = false;
        args = [
          "--tail"
          "50"
          "$FILTER"
          "-n"
          "$NAMESPACE"
          "--context"
          "$CONTEXT"
        ];
      };
    };
  };
}

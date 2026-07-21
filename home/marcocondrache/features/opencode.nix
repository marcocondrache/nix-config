{ lib, ... }:
{
  programs.opencode = {
    enable = lib.mkDefault true;
    package = null; # installed with bun

    settings = {
      autoupdate = true;
      enabled_providers = [ "opencode-go" ];
      mcp = {
        labx = {
          type = "remote";
          url = "https://ai.labx.sh/mcp";
          enabled = true;
          headers = {
            Authorization = "Bearer {file:/run/secrets/opencode/labx-token}";
          };
        };
      };
    };
  };
}

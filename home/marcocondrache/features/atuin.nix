{ pkgs, ... }:
{
  programs.atuin = {
    enable = true;
    package = pkgs.atuin.overrideAttrs { doCheck = false; };
    forceOverwriteSettings = true;

    settings = {
      auto_sync = false;
      update_check = false;
      enter_accept = true;
      sync.records = true;
    };
  };
}

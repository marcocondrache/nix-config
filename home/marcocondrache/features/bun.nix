{ lib, pkgs, config, ... }:
{
  # node -> bun shim so tools that shell out to `node` find bun.
  home.packages = [
    (pkgs.runCommand "node-bun-shim" { } ''
      mkdir -p $out/bin
      ln -s ${lib.getExe config.programs.bun.package} $out/bin/node
    '')
  ];

  programs.bun = {
    enable = lib.mkDefault true;
    enableGitIntegration = lib.mkDefault true;
    settings = {
      telemetry = false;

      run = {
        bun = true;
        silent = true;
      };
    };
  };
}

{
  lib,
  pkgs,
  config,
  ...
}:
let
  os = if pkgs.stdenv.hostPlatform.isDarwin then "darwin" else "os";
in
{
  home.packages = [ pkgs.nix-output-monitor ];

  programs.nh = {
    enable = true;
    flake = "${config.home.homeDirectory}/Personal/nix-config";
  };

  programs.fish.shellAbbrs = {
    nhs = "nh ${os} switch";
    nhb = "nh ${os} build";
    nhu = "nh ${os} switch --update";
    nhd = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin "nh os switch -H devbox --target-host devbox --build-host devbox -e passwordless";
  };
}

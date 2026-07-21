{
  lib,
  config,
  ...
}:
let
  packageNames = map (p: p.pname or p.name or null) config.home.packages;
  hasPackage = name: lib.any (x: x == name) packageNames;
in
{
  imports = [
    ./hydro.nix
    ./zoxide.nix
  ];

  programs.fish = {
    enable = true;

    shellAbbrs = rec {
      g = "git";
      o = "opencode";
      ls = lib.mkIf (hasPackage "eza") "eza";
      ll = lib.mkIf (hasPackage "eza") "eza -la";
      kf = lib.mkIf (hasPackage "kubef") "kubef";
      grep = lib.mkIf (hasPackage "ripgrep") "rg";
      exa = ls;
    };

    functions = {
      fish_greeting = "";
    };
  };
}

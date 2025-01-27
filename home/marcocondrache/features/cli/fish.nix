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
  programs.fish = {
    enable = true;

    shellAbbrs = rec {
      ls = lib.mkIf (hasPackage "eza") "eza";
      exa = ls;
    };

    functions = {
      fish_greeting = "";
    };
  };
}

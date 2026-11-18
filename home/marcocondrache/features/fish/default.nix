{
  lib,
  config,
  ...
}:
{
  imports = [
    ./hydro.nix
  ];

  programs.fish = {
    enable = true;
    generateCompletions = false;

    shellAbbrs = {
      g = "git";
      # opencode is installed through mise
      o = "opencode";
      k = "sofka";
      m = lib.mkIf config.programs.mise.enable "mise";
      ls = "eza";
      ll = "eza -la";
      grep = "rg";
    };

    functions = {
      fish_greeting = "";
    };
  };
}

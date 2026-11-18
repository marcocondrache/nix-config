{
  imports = [
    ./hydro.nix
  ];

  programs.fish = {
    enable = true;
    generateCompletions = false;

    shellAbbrs = {
      g = "git";
      ls = "eza";
      ll = "eza -la";
      grep = "rg";
    };

    functions = {
      fish_greeting = "";
    };
  };
}

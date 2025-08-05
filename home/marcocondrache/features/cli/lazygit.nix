{ pkgs, ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        commit = {
          signOff = true;
        };
      };

      notARepository = "quit";
      promptToReturnFromSubprocess = false;
    };
  };
}

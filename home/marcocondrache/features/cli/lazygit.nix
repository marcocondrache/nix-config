{
  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        commit = {
          signOff = true;
        };

        overrideGpg = true;

        autoForwardBranches = "allBranches";
      };

      notARepository = "quit";
      promptToReturnFromSubprocess = false;
    };
  };
}

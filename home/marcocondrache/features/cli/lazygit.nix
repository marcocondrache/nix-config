{
  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        disableForcePushing = true;

        paging = {
          colorArg = "always";
          pager = "delta --dark --paging=never";
        };
      };
    };
  };
}

{
  imports = [
    ./global
    ./features/desktop
    ./features/web
  ];

  programs.git = {
    extraConfig = {
      user.signingkey = "6CD235683B220034";
      commit.gpgsign = true;
    };
  };
}

{
  imports = [
    ./global
    ./features/desktop
    ./features/web
  ];

  programs.git = {
    extraConfig = {
      user.signingkey = "CA28E81C05CBB973";
      commit.gpgsign = true;
    };
  };
}

{
  programs.mise = {
    enable = true;
    enableFishIntegration = true;

    globalConfig = {
      settings = {
        experimental = true;
        prefer_offline = true;
      };
    };
  };

  programs.git = {
    ignores = [
      "mise.local.toml"
    ];
  };
}

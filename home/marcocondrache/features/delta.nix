{ lib, config, ... }:
{
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      side-by-side = true;
      line-numbers = true;
      hyperlinks = true;
    };
  };

  programs.difftastic.enable = true;

  programs.git.settings = {
    difftool = {
      prompt = false;
      difftastic.cmd = "${lib.getExe config.programs.difftastic.package} $LOCAL $REMOTE";
    };
    alias = {
      dt = "difftool --tool=difftastic";
      dts = "difftool --tool=difftastic --staged";
    };
  };
}

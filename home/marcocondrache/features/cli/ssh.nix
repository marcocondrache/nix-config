{
  # TODO: find a better way to do this
  home.file.".ssh/id_rsa.pub" = {
    source = ../../ssh.pub;
  };

  programs.ssh = {
    enable = true;

    matchBlocks = {
      github = {
        host = "github.com";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_rsa.pub";
      };

      azure = {
        host = "azure.com";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_rsa.pub";
      };
    };
  };
}

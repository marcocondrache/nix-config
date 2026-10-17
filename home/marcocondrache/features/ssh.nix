{
  pkgs,
  ...
}:
{
  # TODO: find a better way to do this
  home.file.".ssh/id_rsa.pub" = {
    source = ../ssh.pub;
  };

  home.file.".ssh/sockets/.keep".text = "";

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    package = pkgs.openssh.override { withFIDO = true; };

    settings = {
      "github.com" = {
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_rsa.pub";
      };

      "azure.com" = {
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_rsa.pub";
      };

      "*" = {
        ControlMaster = "auto";
        # %C keeps the path under the 104-byte unix socket limit; aliases
        # that share host/user/port with another identity need their own
        ControlPath = "~/.ssh/sockets/%C";
        ControlPersist = "4h";
        ServerAliveInterval = 30;
        ServerAliveCountMax = 3;
        UpdateHostKeys = true;
        HashKnownHosts = true;
        AddKeysToAgent = true;
      };
    };
  };
}

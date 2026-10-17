{
  pkgs,
  config,
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
    package = pkgs.openssh;

    settings = {
      "github.com" = {
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_rsa.pub";
      };

      "ssh.dev.azure.com vs-ssh.visualstudio.com" = {
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_rsa.pub";
      };

      "*" = {
        # GUI apps inherit launchd's SSH_AUTH_SOCK, which is Apple's empty agent
        IdentityAgent = "${config.programs.gpg.homedir}/S.gpg-agent.ssh";
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

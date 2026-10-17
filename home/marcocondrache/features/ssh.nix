{
  pkgs,
  lib,
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
      network = {
        RemoteForward = [
          {
            # TODO: find a better way to do this on darwin systems
            bind.address = "/%d/.gnupg-sockets/S.gpg-agent";
            host.address = "/%d/.gnupg/S.gpg-agent.extra";
          }
        ];

        ForwardAgent = true;
        StreamLocalBindUnlink = "yes";
        ExitOnForwardFailure = true;
      };

      "github.com" = {
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_rsa.pub";
      };

      "azure.com" = {
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/id_rsa.pub";
      };
    }
    //
      lib.hm.dag.entriesAfter "ssh-defaults"
        [ "network" ]
        [
          {
            header = "Host *";
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
          }
        ];
  };
}

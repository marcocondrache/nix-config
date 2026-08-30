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
            ControlPath = "~/.ssh/sockets/%r@%h-%p";
            ControlPersist = "4h";
          }
        ];
  };
}

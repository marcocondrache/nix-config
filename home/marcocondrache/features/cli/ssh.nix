{
  lib,
  hosts,
  darwin,
  ...
}:
let
  gpgSocket =
    if darwin then ''/%d/.gnupg/S.gpg-agent.extra'' else ''/%d/.gnupg-sockets/S.gpg-agent.extra'';
in
{
  # TODO: find a better way to do this
  home.file.".ssh/id_rsa.pub" = {
    source = ../../ssh.pub;
  };

  programs.ssh = {
    enable = true;

    matchBlocks = {
      network = {
        host = lib.concatStringsSep " " (
          lib.flatten (
            map (host: [
              "${host}.ts.marcocondrache.com"
            ]) hosts
          )
        );

        remoteForwards = [
          {
            # TODO: find a better way to do this on darwin systems
            bind.address = ''/home/%u/.gnupg-sockets/S.gpg-agent'';
            host.address = ''${gpgSocket}'';
          }
        ];

        forwardAgent = true;
        extraOptions = {
          StreamLocalBindUnlink = "yes";
        };
      };

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

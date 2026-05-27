{
  pkgs,
  darwin,
  ...
}:
let
  gpgSocket =
    if darwin then "/%d/.gnupg/S.gpg-agent.extra" else "/%d/.gnupg-sockets/S.gpg-agent.extra";
in
{
  # TODO: find a better way to do this
  home.file.".ssh/id_rsa.pub" = {
    source = ../ssh.pub;
  };

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
            host.address = "${gpgSocket}";
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
    };
  };
}

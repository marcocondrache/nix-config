{ lib, ... }:

{
  sops = {
    defaultSopsFile = ../secrets.yaml;
    defaultSymlinkPath = "/Users/marcocondrache/.secrets";
    gnupg.home = "/Users/marcocondrache/.gnupg";
    gnupg.sshKeyPaths = [ ];
  };

  launchd.agents.sops-nix.config.KeepAlive = lib.mkForce {
    SuccessfulExit = false;
  };
}

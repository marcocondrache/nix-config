{ lib, config, ... }:

{
  sops = {
    defaultSopsFile = ../secrets.yaml;
    defaultSymlinkPath = "${config.home.homeDirectory}/.secrets";
    gnupg.home = config.programs.gpg.homedir;
    gnupg.sshKeyPaths = [ ];
  };

  launchd.agents.sops-nix.config = {
    KeepAlive = lib.mkForce {
      SuccessfulExit = false;
    };
    # Without the YubiKey every retry pops pinentry again
    ThrottleInterval = 300;
  };
}

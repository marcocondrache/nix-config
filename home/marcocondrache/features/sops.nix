{
  sops = {
    defaultSopsFile = ../secrets.yaml;
    defaultSymlinkPath = "/Users/marcocondrache/.secrets";
    gnupg.home = "/Users/marcocondrache/.gnupg";
    gnupg.sshKeyPaths = [ ];
  };
}

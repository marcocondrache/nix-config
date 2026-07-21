{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [ inputs.sops-nix.darwinModules.sops ];

  sops = {
    gnupg = {
      home = "/Users/marcocondrache/.gnupg";
      sshKeyPaths = [ ];
    };

    defaultSopsFile = ../../../home/marcocondrache/secrets.yaml;

    secrets = {
      "opencode/labx-token" = {
        owner = config.users.users.marcocondrache.name;
        group = "staff";
        mode = "0600";
        sopsFile = ../../../home/marcocondrache/secrets.yaml;
      };
    };
  };

  environment.systemPackages = [ pkgs.gnupg ];
}

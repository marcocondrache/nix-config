{ pkgs, config, ... }:
let
  workEnv = "${config.home.homeDirectory}/Work";
in
{
  imports = [
    ./global
    ./features
  ];

  home.packages = with pkgs; [
    coder
  ];

  sops.secrets."git/work" = { };

  programs.git.includes = [
    {
      condition = "gitdir:${workEnv}/";
      contents = {
        feature.manyFiles = true;
        url."git@danfoss.github.com:".insteadOf = [
          "git@github.com:"
          "https://github.com/"
        ];

        gpg.format = "ssh";
        gpg.ssh.program = "${config.programs.ssh.package}/bin/ssh-keygen";
        gpg.ssh.allowedSignersFile = "${workEnv}/.ssh/allowed_signers";
        user.signingKey = "${workEnv}/.ssh/id_work_ed25519.pub";
      };
    }
    {
      condition = "gitdir:${workEnv}/";
      path = config.sops.secrets."git/work".path;
    }
  ];

  programs.ssh = {
    settings = {
      "danfoss.github.com" = {
        HostName = "github.com";
        IdentitiesOnly = true;
        IdentityFile = "${workEnv}/.ssh/id_work_ed25519";
        AddKeysToAgent = false;
      };
    };

    includes = [
      "${workEnv}/.ssh/coder"
    ];
  };
}

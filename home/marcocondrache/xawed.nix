{ pkgs, config, ... }:
let
  workEnv = "${config.home.homeDirectory}/Work";
in
{
  imports = [
    ./global
    ./features
    ./features/darwin
  ];

  home.packages = [
    # The CLI never runs the provisioner, and unfree terraform isn't cached
    (pkgs.coder.override { terraform = pkgs.emptyDirectory; })
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

        gpg = {
          format = "ssh";
          ssh = {
            program = "${config.programs.ssh.package}/bin/ssh-keygen";
            allowedSignersFile = "${workEnv}/.ssh/allowed_signers";
          };
        };
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
        ControlPath = "~/.ssh/sockets/work-%C";
      };

      # A lingering master connection can hold off workspace autostop
      devbox = {
        HostName = "devbox.local";
        ForwardAgent = true;
        RemoteForward = "/run/user/1000/gnupg/S.gpg-agent ${config.programs.gpg.homedir}/S.gpg-agent.extra";
      };

      "coder.* *.coder" = {
        ControlPersist = "5m";
      };
    };

    includes = [
      "${workEnv}/.ssh/coder"
    ];
  };
}

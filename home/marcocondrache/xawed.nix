{
  config,
  pkgs,
  inputs,
  ...
}:
let
  devboxGnupgDir =
    dirOf
      inputs.self.nixosConfigurations.devbox.config.home-manager.users.${config.home.username}.home.sessionVariables.SSH_AUTH_SOCK;
  utmctl = pkgs.writeShellScriptBin "utmctl" ''
    exec /Applications/UTM.app/Contents/MacOS/utmctl "$@"
  '';
in
{
  home.packages = [
    utmctl
    pkgs.eza
    pkgs.ripgrep
  ];

  programs.git.package = pkgs.git;

  xdg.enable = true;
  home.preferXdgDirectories = true;

  # Apple Virtualization VMs live inside the UTM process, so UTM has to run;
  # keep it out of the Dock and alive with no windows open
  targets.darwin.defaults."com.utmapp.UTM" = {
    HideDockIcon = true;
    ShowMenuIcon = true;
    KeepRunningAfterLastWindowClosed = true;
  };

  launchd.agents.devbox = {
    enable = true;
    config = {
      ProgramArguments = [
        "${utmctl}/bin/utmctl"
        "start"
        "--hide"
        "devbox"
      ];
      RunAtLoad = true;
    };
  };

  imports = [
    ./global
    ./features/fish
    ./features/git.nix
    ./features/gpg.nix
    ./features/nh.nix
    ./features/ssh.nix
    ./features/darwin
  ];

  programs.ssh.settings.devbox = {
    HostName = "devbox.local";
    IdentityFile = "~/.ssh/id_devbox";
    IdentitiesOnly = true;
    IdentityAgent = "none";
    RemoteForward = [
      "${devboxGnupgDir}/S.gpg-agent ${config.programs.gpg.homedir}/S.gpg-agent.extra"
      "${devboxGnupgDir}/S.gpg-agent.ssh ${config.programs.gpg.homedir}/S.gpg-agent.ssh"
    ];
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.skills;

  inherit (lib) mkIf mkOption types;
in
{
  options.programs.skills = {
    enable = lib.mkEnableOption "agent skills repository";

    url = mkOption {
      type = types.str;
      description = "Git URL the skills repository is cloned from.";
      example = "https://github.com/marcocondrache/skills.git";
    };

    pushUrl = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Optional push URL set on the clone, e.g. an SSH remote when cloning over HTTPS.";
      example = "git@github.com:marcocondrache/skills.git";
    };

    path = mkOption {
      type = types.str;
      default = "${config.xdg.dataHome}/skills";
      defaultText = lib.literalExpression ''"''${config.xdg.dataHome}/skills"'';
      description = "Where the skills repository is cloned. The clone is left untouched once it exists.";
    };

    target = mkOption {
      type = types.str;
      default = ".agents";
      description = "Path, relative to the home directory, symlinked to the clone.";
    };
  };

  config = mkIf cfg.enable {
    home.file.${cfg.target}.source = config.lib.file.mkOutOfStoreSymlink cfg.path;

    home.activation.cloneSkills = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ ! -d ${lib.escapeShellArg cfg.path}/.git ]; then
        git=${lib.getExe config.programs.git.package}

        run mkdir -p "$(dirname ${lib.escapeShellArg cfg.path})"
        if ! SSL_CERT_FILE="''${SSL_CERT_FILE:-${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt}" \
          run "$git" clone ${lib.escapeShellArg cfg.url} ${lib.escapeShellArg cfg.path}; then
          warnEcho "Failed to clone ${cfg.url} into ${cfg.path}, will retry on next activation"
        ${lib.optionalString (cfg.pushUrl != null) ''
          else
            run "$git" -C ${lib.escapeShellArg cfg.path} remote set-url --push origin ${lib.escapeShellArg cfg.pushUrl}
        ''}
        fi
      fi
    '';
  };
}

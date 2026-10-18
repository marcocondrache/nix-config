{ config, ... }:
let
  inherit (config.xdg) cacheHome configHome dataHome;
in
{
  xdg.enable = true;
  home.preferXdgDirectories = true;

  # Tools that default to a dotdir in ~ and only move when told to
  home.sessionVariables = {
    CARGO_HOME = "${dataHome}/cargo";
    RUSTUP_HOME = "${dataHome}/rustup";
    GOPATH = "${dataHome}/go";
    NPM_CONFIG_CACHE = "${cacheHome}/npm";
    BUN_INSTALL = "${dataHome}/bun";
    BUN_INSTALL_CACHE_DIR = "${cacheHome}/bun";
    AZURE_CONFIG_DIR = "${configHome}/azure";
    KUBECACHEDIR = "${cacheHome}/kube";
    # Not via programs.docker-cli: its read-only config.json breaks `docker login`
    DOCKER_CONFIG = "${configHome}/docker";
  };
}

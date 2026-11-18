{ lib, ... }:
{
  programs.rex.enable = true;

  # nix-darwin resets PATH on shell start, dropping the rex bin dir Rex prepends
  programs.fish.interactiveShellInit = lib.mkOrder 2000 ''
    if test -n "$REX_BIN_DIR"
        set -gx PATH $REX_BIN_DIR (string match -v -- $REX_BIN_DIR $PATH)
    end
  '';
}

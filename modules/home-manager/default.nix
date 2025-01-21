let
  sharedModules = {
    fonts = import ./fonts.nix;
  };

  darwinModules = {
    xcode = import ./xcode.nix;
  };

  platformModules =
    if
      builtins.elem builtins.currentSystem [
        "aarch64-darwin"
        "x86_64-darwin"
      ]
    then
      darwinModules
    else
      { };
in
sharedModules // platformModules

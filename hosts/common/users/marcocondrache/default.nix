{
  lib,
  system,
  ...
}:
{
  users.users.marcocondrache = {
    name = "marcocondrache";
    home = lib.mkMerge [
      (lib.mkIf (system == "aarch64-darwin") "/Users/marcocondrache")
      (lib.mkIf (system == "aarch64-linux") "/home/marcocondrache")
    ];

    isNormalUser = true;
  };
}

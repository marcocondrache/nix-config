{ pkgs, lib, ... }:
let
  realIpsFromList = lib.strings.concatMapStringsSep "\n" (x: "set_real_ip_from  ${x};");
  fileToList = x: lib.strings.splitString "\n" (builtins.readFile x);
  cfipv4 = fileToList (
    pkgs.fetchurl {
      url = "https://www.cloudflare.com/ips-v4";
      sha256 = "90e01b18eb32b7409496bc2b9f0ac9038f83462cf94c5cbcd57a1a8a40163071";
    }
  );
  cfipv6 = fileToList (
    pkgs.fetchurl {
      url = "https://www.cloudflare.com/ips-v6";
      sha256 = "6daf3f5a4e22a6b98f1af3ee8a666c20dc9733f5df0f133d3c4732a9eb3818d4";
    }
  );
in
{
  services.nginx = {
    commonHttpConfig = ''
      ${realIpsFromList cfipv4}
      ${realIpsFromList cfipv6}

      real_ip_header CF-Connecting-IP;
    '';
  };
}

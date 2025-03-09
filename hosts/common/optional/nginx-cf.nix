{ pkgs, lib, ... }:
let
  realIpsFromList = lib.strings.concatMapStringsSep "\n" (x: "set_real_ip_from  ${x};");
  fileToList = x: lib.strings.splitString "\n" (builtins.readFile x);
  cfipv4 = fileToList (
    pkgs.fetchurl {
      url = "https://www.cloudflare.com/ips-v4";
      sha256 = "f02c6d83bc01ab0ae8577160e036d700c7455359bce054df884e5d7d9e4e9e7b";
    }
  );
  cfipv6 = fileToList (
    pkgs.fetchurl {
      url = "https://www.cloudflare.com/ips-v6";
      sha256 = "9e9d39e3e83bad00c4decafd53c63fa62029f3d95db68de937d2be28234ca0a9";
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

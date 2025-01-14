{
  host,
  pkgs,
  ...
}:
{
  networking = {
    hostName = host;
    computerName = host;
    localHostName = host;
  };

  environment.systemPackages = with pkgs; [
    nil
    nixfmt-rfc-style
  ];

  security.pam.enableSudoTouchIdAuth = true;
}

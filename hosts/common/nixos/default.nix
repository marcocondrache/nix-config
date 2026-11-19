{
  imports = [ ./nix.nix ];

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      # Lets a forwarded gpg-agent socket replace a stale one from a previous session
      StreamLocalBindUnlink = "yes";
    };
  };

  security.sudo.wheelNeedsPassword = false;

  programs.nix-ld.enable = true;

  environment.enableAllTerminfo = true;
}

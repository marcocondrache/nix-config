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

  # Login is key-only through the YubiKey, so there is no password to type
  security.sudo.wheelNeedsPassword = false;

  # Prebuilt binaries from mise, Zed's remote server and friends expect an FHS loader
  programs.nix-ld.enable = true;

  environment.enableAllTerminfo = true;
}

{
  programs.atuin = {
    enable = true;
    forceOverwriteSettings = true;

    settings = {
      auto_sync = false;
      update_check = false;
      enter_accept = true;
      sync.records = true;
    };
  };
}

{
  imports = [
    ../common/global
    ../common/users/marcocondrache/darwin.nix
  ];

  system.defaults = {
    dock = {
      autohide-delay = 0.0;
      autohide-time-modifier = 0.2;
      orientation = "right";
      mru-spaces = false;
      expose-animation-duration = 0.1;
      show-process-indicators = true;
    };

    finder = {
      NewWindowTarget = "Home";
      ShowPathbar = true;
      ShowStatusBar = true;
      _FXSortFoldersFirst = true;
      _FXShowPosixPathInTitle = true;
    };

    NSGlobalDomain = {
      InitialKeyRepeat = 14;

      NSDocumentSaveNewDocumentsToCloud = false;

      # Snappier window animations
      NSWindowResizeTime = 0.001;
      NSAutomaticWindowAnimationsEnabled = false;
    };

    trackpad = {
      Clicking = true;
    };

    loginwindow = {
      GuestEnabled = false;
    };

    menuExtraClock = {
      Show24Hour = true;
      ShowSeconds = false;
    };

    WindowManager = {
      EnableStandardClickToShowDesktop = false;
    };

    screencapture = {
      target = "clipboard";
    };
  };
}

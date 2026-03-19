{
  programs.zed-editor = {
    enable = true;
    package = null;
    userKeymaps = [
      {
        context = "vim_operator == a || vim_operator == i || vim_operator == cs";
        bindings = {
          q = "vim::AnyQuotes";
          b = "vim::AnyBrackets";
        };
      }
      {
        context = "Editor && vim_mode == normal";
        bindings = {
          ctrl-d = [
            "workspace::SendKeystrokes"
            "ctrl-d z z"
          ];
          ctrl-u = [
            "workspace::SendKeystrokes"
            "ctrl-u z z"
          ];
          shift-n = [
            "workspace::SendKeystrokes"
            "shift-n z z"
          ];
          n = [
            "workspace::SendKeystrokes"
            "n z z"
          ];
        };
      }
    ];

    mutableUserKeymaps = false;
  };
}

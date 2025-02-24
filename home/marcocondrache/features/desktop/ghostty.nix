{
  programs.ghostty = {
    enable = true;
    # https://github.com/nix-community/home-manager/blob/6d3163aea47fdb1fe19744e91306a2ea4f602292/modules/programs/ghostty.nix#L34
    package = null;
    settings = {
      theme = "sandbox";

      macos-titlebar-style = "transparent";
      macos-option-as-alt = "left";

      font-family = "Hack";
      font-size = 14;

      window-padding-balance = true;
      window-padding-x = 10;
      window-padding-y = 10;

      adjust-cell-height = "35%";

      keybind = [
        # Pane management
        "super+n=new_split:auto"
        "super+shift+n=new_split:right"
        "super+shift+d=new_split:down"
        "super+x=close_surface"
        "super+f=toggle_fullscreen"

        # Pane navigation
        "super+h=goto_split:left"
        "super+j=goto_split:down"
        "super+k=goto_split:up"
        "super+l=goto_split:right"
        "super+left=goto_split:left"
        "super+down=goto_split:down"
        "super+up=goto_split:up"
        "super+right=goto_split:right"

        # Pane resizing
        "super+shift+h=resize_split:left,10"
        "super+shift+j=resize_split:down,10"
        "super+shift+k=resize_split:up,10"
        "super+shift+l=resize_split:right,10"
        "super+shift+left=resize_split:left,10"
        "super+shift+down=resize_split:down,10"
        "super+shift+up=resize_split:up,10"
        "super+shift+right=resize_split:right,10"

        # Tab management
        "super+t=new_tab"
        "super+w=close_tab"
        "super+1=goto_tab:1"
        "super+2=goto_tab:2"
        "super+3=goto_tab:3"
        "super+4=goto_tab:4"
        "super+5=goto_tab:5"
        "super+6=goto_tab:6"
        "super+7=goto_tab:7"
        "super+8=goto_tab:8"
        "super+9=goto_tab:9"
        "super+ctrl+left=previous_tab"
        "super+ctrl+right=next_tab"

        # Scrollback/search
        "super+s=scroll_page_up"
        "super+d=scroll_page_down"
        "super+/=inspector:toggle"
        "super+c=copy_to_clipboard"
        "super+v=paste_from_clipboard"
        "super+shift+c=clear_screen"

        # Window management
        "super+q=quit"
      ];
    };

    clearDefaultKeybinds = true;

    themes = {
      sandbox = {
        palette = [
          "0=#151515"
          "1=#f48771"
          "2=#cdf861"
          "3=#bfd084"
          "4=#7ad9fb"
          "5=#a390ff"
          "6=#b3e8b4"
          "7=#e5e5e5"
          "8=#6f6f6f"
          "9=#c54444"
          "10=#9fe7a0"
          "11=#f7cc66"
          "12=#7ad9fb"
          "13=#cabeff"
          "14=#86897a"
          "15=#ffffff"
        ];

        background = "151515";
        foreground = "e5e5e5";
        cursor-color = "7ad9fb";
        selection-background = "6f6f6f";
        selection-foreground = "e5e5e5";
      };
    };
  };
}

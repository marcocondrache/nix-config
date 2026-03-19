{
  programs.alacritty = {
    enable = true;
    package = null;

    settings = {
      font = {
        size = 14;
        normal = {
          family = "CommitMono";
          style = "Regular";
        };

        offset = {
          y = 3;
        };
      };

      window = {
        padding = {
          x = 10;
          y = 10;
        };

        opacity = 1.0;
        blur = false;
        dynamic_padding = true;
      };

      cursor = {
        style = {
          shape = "Block";
          blinking = "Off";
        };
        thickness = 0.15;
      };

      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      selection = {
        save_to_clipboard = true;
      };

      keyboard = {
        bindings = [
          {
            key = "Right";
            mods = "Alt|Command";
            action = "SelectNextTab";
          }
          {
            key = "Left";
            mods = "Alt|Command";
            action = "SelectPreviousTab";
          }
        ];
      };

      colors = {
        primary = {
          background = "#151515";
          foreground = "#e5e5e5";
        };

        cursor = {
          text = "#151515";
          cursor = "#7ad9fb";
        };

        selection = {
          text = "#e5e5e5";
          background = "#6f6f6f";
        };

        normal = {
          black = "#151515";
          red = "#f48771";
          green = "#cdf861";
          yellow = "#bfd084";
          blue = "#7ad9fb";
          magenta = "#a390ff";
          cyan = "#b3e8b4";
          white = "#e5e5e5";
        };

        bright = {
          black = "#6f6f6f";
          red = "#c54444";
          green = "#9fe7a0";
          yellow = "#f7cc66";
          blue = "#7ad9fb";
          magenta = "#cabeff";
          cyan = "#86897a";
          white = "#ffffff";
        };
      };
    };
  };
}

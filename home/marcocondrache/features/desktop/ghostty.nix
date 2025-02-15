{
  programs.ghostty = {
    enable = true;
    # https://github.com/nix-community/home-manager/blob/6d3163aea47fdb1fe19744e91306a2ea4f602292/modules/programs/ghostty.nix#L34
    package = null;
    settings = {
      theme = "sandbox";

      macos-titlebar-style = "transparent";

      font-family = "Hack";
      font-size = 14;

      # window-padding-balance = true;
      # window-padding-x = 10;
      # window-padding-y = 10;

      # adjust-cell-height = "35%";

      keybind = [
        "cmd+t=unbind"
        "cmd+n=unbind"
        "cmd+c=unbind"
        "cmd+w=unbind"
        "cmd+opt+left=unbind"
        "cmd+opt+right=unbind"
      ];
    };

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

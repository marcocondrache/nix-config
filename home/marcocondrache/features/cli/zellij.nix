let
  primary_modifier = "Super";
  secondary_modifier = "Ctrl";
in
{
  programs.zellij = {
    enable = true;

    settings = {
      ui = {
        pane_frames = {
          hide_session_name = true;
          rounded_corners = true;
        };
      };

      default_mode = "locked";

      on_force_close = "quit";
      session_serialization = false;
    };
  };

  xdg.configFile."zellij/config.kdl".text = ''
        keybinds clear-defaults=true {
        normal {
        }
        locked {
            bind "${primary_modifier} g" { SwitchToMode "Normal"; }
        }
        resize {
            bind "r" { SwitchToMode "Normal"; }
            bind "h" "Left" { Resize "Increase Left"; }
            bind "j" "Down" { Resize "Increase Down"; }
            bind "k" "Up" { Resize "Increase Up"; }
            bind "l" "Right" { Resize "Increase Right"; }
            bind "H" { Resize "Decrease Left"; }
            bind "J" { Resize "Decrease Down"; }
            bind "K" { Resize "Decrease Up"; }
            bind "L" { Resize "Decrease Right"; }
            bind "=" "+" { Resize "Increase"; }
            bind "-" { Resize "Decrease"; }
        }
        pane {
            bind "p" { SwitchToMode "Normal"; }
            bind "h" "Left" { MoveFocus "Left"; }
            bind "l" "Right" { MoveFocus "Right"; }
            bind "j" "Down" { MoveFocus "Down"; }
            bind "k" "Up" { MoveFocus "Up"; }
            bind "Tab" { SwitchFocus; }
            bind "n" { NewPane; SwitchToMode "Locked"; }
            bind "d" { NewPane "Down"; SwitchToMode "Locked"; }
            bind "r" { NewPane "Right"; SwitchToMode "Locked"; }
            bind "x" { CloseFocus; SwitchToMode "Locked"; }
            bind "f" { ToggleFocusFullscreen; SwitchToMode "Locked"; }
            bind "z" { TogglePaneFrames; SwitchToMode "Locked"; }
            bind "w" { ToggleFloatingPanes; SwitchToMode "Locked"; }
            bind "e" { TogglePaneEmbedOrFloating; SwitchToMode "Locked"; }
            bind "c" { SwitchToMode "RenamePane"; PaneNameInput 0;}
        }
        move {
            bind "m" { SwitchToMode "Normal"; }
            bind "n" "Tab" { MovePane; }
            bind "p" { MovePaneBackwards; }
            bind "h" "Left" { MovePane "Left"; }
            bind "j" "Down" { MovePane "Down"; }
            bind "k" "Up" { MovePane "Up"; }
            bind "l" "Right" { MovePane "Right"; }
        }
        tab {
            bind "t" { SwitchToMode "Normal"; }
            bind "r" { SwitchToMode "RenameTab"; TabNameInput 0; }
            bind "h" "Left" "Up" "k" { GoToPreviousTab; }
            bind "l" "Right" "Down" "j" { GoToNextTab; }
            bind "n" { NewTab; SwitchToMode "Locked"; }
            bind "x" { CloseTab; SwitchToMode "Locked"; }
            bind "s" { ToggleActiveSyncTab; SwitchToMode "Locked"; }
            bind "b" { BreakPane; SwitchToMode "Locked"; }
            bind "]" { BreakPaneRight; SwitchToMode "Locked"; }
            bind "[" { BreakPaneLeft; SwitchToMode "Locked"; }
            bind "1" { GoToTab 1; SwitchToMode "Locked"; }
            bind "2" { GoToTab 2; SwitchToMode "Locked"; }
            bind "3" { GoToTab 3; SwitchToMode "Locked"; }
            bind "4" { GoToTab 4; SwitchToMode "Locked"; }
            bind "5" { GoToTab 5; SwitchToMode "Locked"; }
            bind "6" { GoToTab 6; SwitchToMode "Locked"; }
            bind "7" { GoToTab 7; SwitchToMode "Locked"; }
            bind "8" { GoToTab 8; SwitchToMode "Locked"; }
            bind "9" { GoToTab 9; SwitchToMode "Locked"; }
            bind "Tab" { ToggleTab; }
        }
        scroll {
            bind "s" { SwitchToMode "Normal"; }
            bind "e" { EditScrollback; SwitchToMode "Locked"; }
            bind "f" { SwitchToMode "EnterSearch"; SearchInput 0; }
            bind "Ctrl c" { ScrollToBottom; SwitchToMode "Locked"; }
            bind "j" "Down" { ScrollDown; }
            bind "k" "Up" { ScrollUp; }
            bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
            bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
            bind "d" { HalfPageScrollDown; }
            bind "u" { HalfPageScrollUp; }
            bind "Alt left" { MoveFocusOrTab "left"; SwitchToMode "locked"; }
            bind "Alt down" { MoveFocus "down"; SwitchToMode "locked"; }
            bind "Alt up" { MoveFocus "up"; SwitchToMode "locked"; }
            bind "Alt right" { MoveFocusOrTab "right"; SwitchToMode "locked"; }
            bind "Alt h" { MoveFocusOrTab "left"; SwitchToMode "locked"; }
            bind "Alt j" { MoveFocus "down"; SwitchToMode "locked"; }
            bind "Alt k" { MoveFocus "up"; SwitchToMode "locked"; }
            bind "Alt l" { MoveFocusOrTab "right"; SwitchToMode "locked"; }
        }
        search {
            bind "Ctrl c" { ScrollToBottom; SwitchToMode "Locked"; }
            bind "j" "Down" { ScrollDown; }
            bind "k" "Up" { ScrollUp; }
            bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
            bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
            bind "d" { HalfPageScrollDown; }
            bind "u" { HalfPageScrollUp; }
            bind "n" { Search "down"; }
            bind "p" { Search "up"; }
            bind "c" { SearchToggleOption "CaseSensitivity"; }
            bind "w" { SearchToggleOption "Wrap"; }
            bind "o" { SearchToggleOption "WholeWord"; }
        }
        entersearch {
            bind "Ctrl c" "Esc" { SwitchToMode "Scroll"; }
            bind "Enter" { SwitchToMode "Search"; }
        }
        renametab {
            bind "Ctrl c" "Enter" { SwitchToMode "Locked"; }
            bind "Esc" { UndoRenameTab; SwitchToMode "Tab"; }
        }
        renamepane {
            bind "Ctrl c" "Enter" { SwitchToMode "Locked"; }
            bind "Esc" { UndoRenamePane; SwitchToMode "Pane"; }
        }
        session {
            bind "o" { SwitchToMode "Normal"; }
            bind "d" { Detach; }
            bind "w" {
                LaunchOrFocusPlugin "session-manager" {
                    floating true
                    move_to_focused_tab true
                };
                SwitchToMode "Locked"
            }
            bind "c" {
                LaunchOrFocusPlugin "configuration" {
                    floating true
                    move_to_focused_tab true
                };
                SwitchToMode "Locked"
            }
            bind "p" {
                LaunchOrFocusPlugin "plugin-manager" {
                    floating true
                    move_to_focused_tab true
                };
                SwitchToMode "Locked"
            }
        }
        shared_except "locked" "renametab" "renamepane" {
            bind "${primary_modifier} g" { SwitchToMode "Locked"; }
            bind "${primary_modifier} q" { Quit; }
        }
        shared_except "renamepane" "renametab" "entersearch" "locked" {
            bind "esc" { SwitchToMode "locked"; }
        }
        shared_among "normal" "locked" {
            bind "${secondary_modifier} n" { NewPane; }
            bind "${secondary_modifier} f" { ToggleFloatingPanes; }
            bind "${secondary_modifier} i" { MoveTab "Left"; }
            bind "${secondary_modifier} o" { MoveTab "Right"; }
            bind "${secondary_modifier} h" "${secondary_modifier} Left" { MoveFocusOrTab "Left"; }
            bind "${secondary_modifier} l" "${secondary_modifier} Right" { MoveFocusOrTab "Right"; }
            bind "${secondary_modifier} j" "${secondary_modifier} Down" { MoveFocus "Down"; }
            bind "${secondary_modifier} k" "${secondary_modifier} Up" { MoveFocus "Up"; }
            bind "${secondary_modifier} =" "${secondary_modifier} +" { Resize "Increase"; }
            bind "${secondary_modifier} -" { Resize "Decrease"; }
        }
        shared_except "locked" "renametab" "renamepane" {
            bind "Enter" { SwitchToMode "Locked"; }
        }
        shared_except "pane" "locked" "renametab" "renamepane" "entersearch" {
            bind "p" { SwitchToMode "Pane"; }
        }
        shared_except "resize" "locked" "renametab" "renamepane" "entersearch" {
            bind "r" { SwitchToMode "Resize"; }
        }
        shared_except "scroll" "locked" "renametab" "renamepane" "entersearch" {
            bind "s" { SwitchToMode "Scroll"; }
        }
        shared_except "session" "locked" "renametab" "renamepane" "entersearch" {
            bind "o" { SwitchToMode "Session"; }
        }
        shared_except "tab" "locked" "renametab" "renamepane" "entersearch" {
            bind "t" { SwitchToMode "Tab"; }
        }
        shared_except "move" "locked" "renametab" "renamepane" "entersearch" {
            bind "m" { SwitchToMode "Move"; }
        }
    }
  '';
}

{
  programs.zed-editor = {
    enable = true;
    package = null;

    mutableUserKeymaps = false;
    mutableUserSettings = false;

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

    userSettings = {
      base_keymap = "Cursor";

      vim_mode = true;
      vim.toggle_relative_line_numbers = false;

      theme = {
        mode = "dark";
        dark = "One Dark";
        light = "One Light";
      };

      icon_theme = {
        mode = "dark";
        dark = "Zed (Default)";
        light = "Zed (Default)";
      };

      ui_font_size = 16;
      buffer_font_family = "CommitMono";
      buffer_font_size = 14;

      cursor_blink = false;
      gutter.line_numbers = true;
      relative_line_numbers = "wrapped";
      colorize_brackets = false;
      document_folding_ranges = "off";
      use_smartcase_search = true;

      indent_guides = {
        coloring = "fixed";
        background_coloring = "disabled";
      };

      scroll_beyond_last_line = "one_page";
      scroll_sensitivity = 1.0;
      vertical_scroll_margin = 0.0;
      scrollbar.show = "never";
      sticky_scroll.enabled = true;

      minimap = {
        show = "never";
        display_in = "all_editors";
        max_width_columns = 80;
      };

      semantic_tokens = "combined";
      inlay_hints.enabled = false;
      auto_signature_help = false;
      go_to_definition_fallback = "none";
      diagnostics.inline.enabled = true;

      lsp."rust-analyzer".initialization_options.rust.analyzerTargetDir = true;

      preview_tabs = {
        enable_keep_preview_on_code_navigation = true;
        enable_preview_multibuffer_from_code_navigation = true;
      };

      tabs = {
        file_icons = false;
        git_status = true;
      };

      expand_excerpt_lines = 7;
      double_click_in_multibuffer = "open";

      use_system_window_tabs = false;

      title_bar = {
        show_menus = false;
        show_sign_in = true;
        show_branch_status_icon = true;
      };

      project_panel = {
        dock = "right";
        hide_hidden = false;
        hide_root = false;
        entry_spacing = "comfortable";
      };

      outline_panel.dock = "right";
      collaboration_panel.dock = "right";

      git_panel = {
        dock = "right";
        tree_view = true;
      };

      git.inline_blame = {
        enabled = true;
        show_commit_summary = false;
      };

      diff_view_style = "unified";
      word_diff_enabled = true;

      terminal = {
        dock = "bottom";
        font_size = 14.0;
        scroll_multiplier = 1.0;
      };

      show_edit_predictions = true;
      edit_predictions.provider = "zed";

      agent = {
        dock = "left";
        terminal_init_command = "opencode";
        tool_permissions.tools.terminal.default = "allow";

        model_parameters = [ ];
      };

      telemetry = {
        metrics = false;
        diagnostics = false;
      };
    };
  };
}

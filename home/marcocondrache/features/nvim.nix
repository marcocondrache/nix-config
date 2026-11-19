{ inputs, ... }:
{
  imports = [ inputs.nixvim.homeModules.nixvim ];

  programs.nixvim = {
    enable = true;
    nixpkgs.source = inputs.nixpkgs;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    globals.mapleader = " ";

    opts = {
      sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal";
      number = true;
      relativenumber = true;
      signcolumn = "yes";
      ignorecase = true;
      smartcase = true;
      scrolloff = 0;
      undofile = true;
      splitright = true;
      splitbelow = true;
      termguicolors = true;
    };

    colorschemes.base16 = {
      enable = true;
      colorscheme = "tomorrow-night";
    };

    diagnostic.settings.virtual_text = true;

    keymaps =
      map
        (key: {
          mode = "n";
          inherit key;
          action = "${key}zz";
        })
        [
          "<C-d>"
          "<C-u>"
          "n"
          "N"
        ]
      ++ [
        {
          mode = "n";
          key = "<leader><space>";
          action = "<cmd>Telescope find_files<cr>";
        }
        {
          mode = "n";
          key = "<leader>/";
          action = "<cmd>Telescope live_grep<cr>";
        }
        {
          mode = "n";
          key = "<leader>p";
          action = "<cmd>Telescope zoxide list<cr>";
        }
        {
          mode = "n";
          key = "<leader>P";
          action = "<cmd>tabnew | Telescope zoxide list<cr>";
        }
        {
          mode = "n";
          key = "<leader>b";
          action = "<cmd>Telescope buffers<cr>";
        }
        {
          mode = "n";
          key = "<leader>s";
          action = "<cmd>Telescope lsp_document_symbols<cr>";
        }
        {
          mode = "n";
          key = "<leader>d";
          action = "<cmd>Telescope diagnostics<cr>";
        }
        {
          mode = "n";
          key = "<leader>e";
          action = "<cmd>Neotree toggle reveal<cr>";
        }
        {
          mode = "n";
          key = "<leader>g";
          action = "<cmd>Neogit<cr>";
        }
      ];

    plugins = {
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };
      treesitter-context.enable = true;

      lsp = {
        enable = true;
        inlayHints = false;
        keymaps.lspBuf = {
          gd = "definition";
          gr = "references";
          gi = "implementation";
          K = "hover";
          "<leader>r" = "rename";
          "<leader>a" = "code_action";
        };
        servers = {
          nixd.enable = true;
          rust_analyzer = {
            enable = true;
            # cargo and rustc come from rustup via mise; its rust-analyzer proxy
            # loops back into mise's shim when the component isn't installed
            installCargo = false;
            installRustc = false;
            settings.cargo.targetDir = true;
          };
        };
      };

      blink-cmp = {
        enable = true;
        settings.signature.enabled = false;
      };

      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft.nix = [ "nixfmt" ];
          format_on_save.lsp_format = "fallback";
        };
      };

      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
          zoxide = {
            enable = true;
            settings.mappings.default.action.__raw = ''
              function(selection) vim.cmd.tcd(selection.path) end
            '';
          };
        };
      };

      auto-session = {
        enable = true;
        settings = {
          suppressed_dirs = [
            "~/"
            "/"
            "/tmp"
          ];
          pre_save_cmds = [ "tabdo Neotree close" ];
        };
      };

      neo-tree = {
        enable = true;
        settings = {
          window.position = "right";
          filesystem.filtered_items.visible = true;
        };
      };

      gitsigns = {
        enable = true;
        settings = {
          current_line_blame = true;
          current_line_blame_formatter = "<author>, <author_time:%R>";
        };
      };
      neogit.enable = true;
      diffview.enable = true;

      mini-ai.enable = true;
      web-devicons.enable = true;
    };
  };
}

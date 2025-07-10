{delib, ...}:
delib.module {
  # finder
  name = "programs.nixvim.plugins.telescope";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.nixvim = {
      keymaps = [
        {
          key = "<leader>ff";
          action = "<cmd>Telescope frecency workspace=CWD<cr>";
          options = {desc = "find commonly edited files";};
        }
        {
          key = "<leader>fm";
          action = "<cmd>Telescope marks<cr>";
          options = {desc = "find marks";};
        }
        {
          key = "<leader>fo";
          action = "<cmd>Telescope oldfiles<cr>";
          options = {desc = "find last edited files";};
        }
        {
          key = "<leader>fr";
          action = "<cmd>Telescope resume<cr>";
          options = {desc = "resume last search";};
        }
        {
          key = "<leader>fs";
          action = "<cmd>Telescope live_grep<cr>";
          options = {desc = "search project";};
        }
        {
          key = "<leader>fw";
          action = "<cmd>Telescope grep_string<cr>";
          options = {desc = "search project for current word";};
        }
        {
          key = "<leader>cd";
          action = "<cmd>Telescope lsp_definitions<cr>";
          options = {desc = "goto definition";};
        }
        {
          key = "<leader>cu";
          action = "<cmd>Telescope lsp_references<cr>";
          options = {desc = "show lsp referenecs";};
        }
        {
          key = "<leader>p";
          action = "<cmd>Telescope yank_history<cr>";
          options = {desc = "paste from history";};
        }
        {
          key = "<leader>t";
          action = "<cmd>Telescope find_files<cr>";
          options = {desc = "paste from history";};
        }
        {
          key = "<leader><space>";
          action = "<cmd>Telescope find_files<cr>";
          options = {desc = "find files";};
        }
      ];

      plugins.telescope = {
        enable = true;

        extensions = {
          frecency = {
            enable = true;
          };
          fzf-native = {
            enable = true;
          };
        };

        settings = {
          defaults = {
            # the colors are distracting and not very useful
            color_devicons = false;
            mappings = {
              i = {
                "<C-n>" = "move_selection_next";
                "<C-e>" = "move_selection_previous";
              };
            };
            preview = {
              # disable preview for large files
              filesize_limit = 0.2;
            };
            sorting_strategy = "ascending";
            # include hidden files by default
            vimgrep_arguments = [
              "rg"
              "--color=never"
              "--no-heading"
              "--with-filename"
              "--line-number"
              "--column"
              "--smart-case"
              "--hidden"
            ];
          };

          pickers = {
            find_files = {
              # include hidden files by default
              find_command = ["fd" "--type" "f" "--hidden"];
            };
            oldfiles = {
              # only show files in cwd
              only_cwd = true;
            };
          };
        };

        # delay loading until requested
        # TODO: this was causing settings to not be applied
        # lazyLoad.settings = {
        #   cmd = "Telescope";
        # };
      };
    };
  };
}

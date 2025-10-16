{delib, ...}:
delib.module {
  # finder
  name = "programs.nixvim.plugins.telescope";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.nixvim = {
      plugins.telescope = {
        enable = true;

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
      };
    };
  };
}

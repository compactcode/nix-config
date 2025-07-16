{delib, ...}:
delib.module {
  # test runner
  name = "programs.nixvim.plugins.neotest";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim = {
    # enable colorscheme
    colorschemes.catppuccin = {
      settings = {
        integrations = {
          neotest = true;
        };
      };
    };

    plugins.neotest = {
      enable = true;

      # ruby
      adapters.rspec.enable = true;

      settings = {
        # disable scanning for test files
        discovery.enable = false;
        # disable quickfix integration
        quickfix.enable = false;
      };

      lazyLoad.settings = {
        cmd = "Neotest";
        keys = [
          {
            __unkeyed-1 = "gt";
            __unkeyed-2 = "<cmd>lua require('neotest').jump.next({ status = 'failed' })<cr>";
            desc = "jump to next failed test";
          }
          {
            __unkeyed-1 = "<leader>ra";
            __unkeyed-2 = "<cmd>lua require('neotest').run.run(vim.fn.expand(\"%\"))<cr>";
            desc = "run file";
          }
          {
            __unkeyed-1 = "<leader>rn";
            __unkeyed-2 = "<cmd>lua require('neotest').run.run()<cr>";
            desc = "run nearest";
          }
          {
            __unkeyed-1 = "<leader>ro";
            __unkeyed-2 = "<cmd>lua require('neotest').output.open()<cr>";
            desc = "test output";
          }
          {
            __unkeyed-1 = "<leader>rr";
            __unkeyed-2 = "<cmd>lua require('neotest').run.run_last()<cr>";
            desc = "run last test";
          }
        ];
      };
    };
  };
}

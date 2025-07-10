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
            key = "gt";
            value = "<cmd>lua require('neotest').jump.next({ status = 'failed' })<cr>";
            desc = "jump to next failed test";
          }
          {
            key = "<leader>ra";
            value = "<cmd>lua require('neotest').run.run(vim.fn.expand(\"%\"))<cr>";
            desc = "run file";
          }
          {
            key = "<leader>rn";
            value = "<cmd>lua require('neotest').run.run()<cr>";
            desc = "run nearest";
          }
          {
            key = "<leader>ro";
            value = "<cmd>lua require('neotest').output.open()<cr>";
            desc = "test output";
          }
          {
            key = "<leader>rr";
            value = "<cmd>lua require('neotest').run.run_last()<cr>";
            desc = "run last test";
          }
        ];
      };
    };
  };
}

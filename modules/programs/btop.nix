{delib, ...}:
delib.module {
  # system monitor
  name = "programs.btop";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.btop = {
      enable = true;
      settings = {
        # show cpu usage of the core rather than total
        proc_per_core = true;
        # show processes in a tree
        proc_tree = true;
      };
    };
  };
}

{delib, ...}:
delib.module {
  # git ui
  name = "programs.lazygit";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.shellAliases = {
      lg = "lazygit";
    };

    programs.lazygit = {
      enable = true;
      settings = {
        git = {
          # annoying as it prompts for authentication
          autoFetch = false;
        };
      };
    };

    # automatic styling
    stylix.targets.lazygit.enable = true;
  };
}

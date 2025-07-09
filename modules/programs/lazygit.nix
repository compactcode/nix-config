{delib, ...}:
delib.module {
  # git ui
  name = "progams.lazygit";

  options = {myconfig, ...} @ args: delib.singleEnableOption myconfig.host.isDesktop args;

  home.ifEnabled = {
    programs.lazygit = {
      enable = true;
      settings = {
        git = {
          # annoying as it prompts for authentication
          autoFetch = false;
        };
      };
    };

    home = {
      shellAliases = {
        lg = "lazygit";
      };
    };
  };
}

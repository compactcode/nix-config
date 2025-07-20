{
  delib,
  pkgs,
  ...
}:
delib.module {
  # markdown viewer
  name = "programs.obsidian";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = [pkgs.obsidian];

    # TODO: Resolve https://github.com/nix-community/home-manager/issues/7406
    # programs.obsidian = {
    #   enable = true;
    #   defaultSettings = {
    #     corePlugins = [
    #       "command-palette"
    #       "editor-status"
    #       "file-explorer"
    #       "file-recovery"
    #       "global-search"
    #       "outline"
    #       "page-preview"
    #       "switcher"
    #       "tag-pane"
    #       "sync"
    #     ];
    #   };
    #   vaults = {
    #     personal = {
    #       target = "${homeconfig.xdg.userDirs.documents}/personal";
    #     };
    #     zepto = {
    #       target = "${homeconfig.xdg.userDirs.documents}/zepto";
    #     };
    #   };
    # };
  };
}

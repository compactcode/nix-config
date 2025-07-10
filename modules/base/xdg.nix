{
  delib,
  homeconfig,
  ...
}:
delib.module {
  name = "xdg";

  options = {myconfig, ...}:
    with delib; {
      enable = boolOption myconfig.host.isDesktop;
      projectHome = strOption "${homeconfig.home.homeDirectory}/Projects";
    };

  home.ifEnabled = {cfg, ...}: {
    xdg = {
      enable = true;
      # create default desktop directories
      userDirs = {
        enable = true;
        createDirectories = true;
        extraConfig = {
          XDG_PROJECTS_DIR = cfg.projectHome;
        };
      };
    };
  };
}

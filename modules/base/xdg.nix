{
  delib,
  homeconfig,
  pkgs,
  ...
}:
delib.module {
  name = "xdg";

  options = {myconfig, ...}: {
    xdg = with delib; {
      enable = boolOption myconfig.host.isDesktop;
      projectHome = strOption "${homeconfig.home.homeDirectory}/Projects";
    };
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

  nixos.ifEnabled = {
    # allow applications to request system resources
    xdg.portal = {
      enable = true;

      config.common.default = ["gtk"];

      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };
}

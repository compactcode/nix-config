{
  delib,
  homeconfig,
  pkgs,
  ...
}:
delib.module {
  name = "xdg";

  options = {
    xdg = with delib; {
      enable = boolOption pkgs.stdenv.isLinux;
      projectHome = strOption "${homeconfig.home.homeDirectory}/Projects";
    };
  };

  home.ifEnabled = {cfg, ...}: {
    xdg = {
      enable = true;

      # set preferred applications
      mimeApps = {
        enable = true;
        defaultApplications = {
          "application/pdf" = "org.pwmt.zathura.desktop";
          "image/gif" = "imv.desktop";
          "image/jpeg" = "imv.desktop";
          "image/png" = "imv.desktop";
          "image/svg+xml" = "imv.desktop";
          "image/tiff" = "imv.desktop";
          "image/webp" = "imv.desktop";
          "inode/directory" = "yazi.desktop";
          "text/html" = "firefox.desktop";
          "text/markdown" = "nvim.desktop";
          "text/plain" = "nvim.desktop";
          "video/mp4" = "mpv.desktop";
          "video/quicktime" = "mpv.desktop";
          "video/x-matroska" = "mpv.desktop";
          "video/x-ms-wmv" = "mpv.desktop";
          "x-scheme-handler/http" = "firefox.desktop";
          "x-scheme-handler/https" = "firefox.desktop";
        };
      };

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

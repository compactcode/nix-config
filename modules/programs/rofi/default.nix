{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.rofi";

  options = {myconfig, ...}: {
    programs.rofi = with delib; {
      enable = boolOption myconfig.services.hyprland.enable;
    };
  };

  home.ifEnabled = {
    home.packages = [
      # command line bookmark manager
      pkgs.buku
    ];

    programs = {
      # application launcher
      rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
      };
    };

    xdg = {
      dataFile = {
        # open browser bookmark
        "rofi/bookmark.sh" = {
          executable = true;
          source = ./scripts/bookmark.sh;
        };

        # focus/create kitty session
        "rofi/project.sh" = {
          executable = true;
          source = ./scripts/project.sh;
        };
      };
    };
  };
}

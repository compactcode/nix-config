{
  delib,
  pkgs,
  ...
}:
delib.module {
  # application launcher
  name = "programs.rofi";

  options = {myconfig, ...}: {
    programs.rofi = with delib; {
      enable = boolOption myconfig.programs.hyprland.enable;
    };
  };

  home.ifEnabled = {
    home.packages = [
      # command line bookmark manager
      pkgs.buku
    ];

    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
    };

    # automatic styling
    stylix.targets.rofi.enable = true;

    xdg.dataFile = {
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
}

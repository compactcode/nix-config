{
  delib,
  pkgs,
  ...
}:
delib.module {
  # application launcher
  name = "programs.rofi";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = [
      # command line bookmark manager
      pkgs.buku
    ];

    programs.rofi = {
      enable = true;
      package = pkgs.rofi;
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

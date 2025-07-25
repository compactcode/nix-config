{
  delib,
  pkgs,
  ...
}:
delib.rice {
  # a minimal theme for servers
  name = "tokyo-night-storm";

  home = {
    programs = {
      nixvim = {
        colorschemes.tokyonight = {
          enable = true;
          settings = {
            style = "storm";
          };
        };
      };
    };
  };

  nixos = {
    stylix = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";

      # dark mode
      polarity = "dark";
    };
  };
}

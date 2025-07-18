{
  delib,
  pkgs,
  ...
}:
delib.rice {
  name = "catppuccin-mocha";

  darwin = {
    stylix = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

      fonts = {
        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };

        monospace = {
          package = pkgs.nerd-fonts.sauce-code-pro;
          name = "Sauce Code Pro Nerd Font";
        };

        sansSerif = {
          package = pkgs.rubik;
          name = "Rubik";
        };

        serif = {
          package = pkgs.noto-fonts;
          name = "Noto Serif";
        };
      };

      # dark mode
      polarity = "dark";
    };
  };

  home = {
    programs.opencode.settings.theme = "catppuccin";
  };

  nixos = {
    stylix = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 24;
      };

      fonts = {
        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };

        monospace = {
          package = pkgs.nerd-fonts.sauce-code-pro;
          name = "Sauce Code Pro Nerd Font";
        };

        sansSerif = {
          package = pkgs.rubik;
          name = "Rubik";
        };

        serif = {
          package = pkgs.noto-fonts;
          name = "Noto Serif";
        };
      };

      image = ../wallpapers/space.jpg;

      # dark mode
      polarity = "dark";
    };
  };
}

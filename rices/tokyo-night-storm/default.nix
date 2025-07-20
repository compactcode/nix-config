{
  delib,
  pkgs,
  ...
}:
delib.rice {
  name = "tokyo-night-storm";

  darwin = {
    stylix = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";

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
    programs = {
      # TODO e=EACCES: permission denied, open '/home/shandogs/.config/opencode/config.json'
      # programs.opencode.settings.theme = "catppuccin";
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

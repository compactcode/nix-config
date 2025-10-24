{
  delib,
  pkgs,
  ...
}:
delib.rice {
  # a complete theme for desktops
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
    gtk = {
      # gnome specific icons
      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };
    };

    programs = {
      # TODO e=EACCES: permission denied, open '/home/shandogs/.config/opencode/config.json'
      # programs.opencode.settings.theme = "catppuccin";
      nixvim = {
        colorschemes.catppuccin = {
          enable = true;
          settings = {
            flavour = "mocha";
          };
        };
      };
    };
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

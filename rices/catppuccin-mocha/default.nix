{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.rice {
  name = "catppuccin-mocha";

  darwin = {
    imports = [inputs.stylix.darwinModules.stylix];

    stylix = {
      enable = true;

      autoEnable = false;

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
    # enable for stylix
    gtk.enable = true;

    stylix.targets = {
      bat.enable = true;
      btop.enable = true;
      gnome.enable = true;
      gtk.enable = true;
      kde.enable = true;
      kitty.enable = true;
      lazygit.enable = true;
      mpv.enable = true;
      rofi.enable = true;
      swaylock.enable = true;
      waybar.enable = true;
      yazi.enable = true;
      zathura.enable = true;
    };
  };

  nixos = {
    imports = [inputs.stylix.nixosModules.stylix];

    stylix = {
      enable = true;

      autoEnable = false;

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

      # dark mode
      polarity = "dark";

      targets = {
        chromium.enable = true;
        console.enable = true;
      };
    };
  };
}

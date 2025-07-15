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

  home = {myconfig, ...}: {
    stylix.targets = {
      bat.enable = myconfig.programs.bat.enable;
      btop.enable = myconfig.programs.btop.enable;
      gnome.enable = myconfig.gtk.enable;
      gtk.enable = myconfig.gtk.enable;
      kde.enable = myconfig.gtk.enable;
      kitty.enable = myconfig.programs.kitty.enable;
      lazygit.enable = myconfig.programs.lazygit.enable;
      mpv.enable = myconfig.programs.mpv.enable;
      rofi.enable = myconfig.programs.rofi.enable;
      starship.enable = myconfig.programs.starship.enable;
      swaylock.enable = myconfig.programs.swaylock.enable;
      waybar.enable = myconfig.programs.waybar.enable;
      yazi.enable = myconfig.programs.yazi.enable;
      zathura.enable = myconfig.programs.zathura.enable;
    };
  };

  nixos = {myconfig, ...}: {
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
        chromium.enable = myconfig.programs.chromium.enable;
        console.enable = true;
      };
    };
  };
}
